const express = require('express');
const router = express.Router();

const session = require('express-session');
//----------------------------------------------------------------------------------------------
//  --* Connection Module *--
var conn = require('../connection');
//  --* File Upload Module *--
const save_file_on_server = require('../uploadfile');
//----------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------

//----------------------------------------------------------------------------------------------

router.post('/check-out', (req, res) => {
    // console.log(req.body);
    let customerid = session.UserID ;
    let name = session.UserName;

    let paymentmode = req.body.PaymentMethod;
    let mobile = req.body.mobile;
    let address = req.body.address;
    let remarks = req.body.remarks;
    let grandtotal = req.body.grandtotal;
    // let refid = req.body.paymentid;
    let status = 'Pending';

    // date --> Javascript
    let currentDate = new Date();
    let cDay = currentDate.getDate();
    let cMonth = currentDate.getMonth() + 1;
    let cYear = currentDate.getFullYear();

    let date = cYear + '-' + cMonth + '-' + cDay;

    // INSERT INTO `bill`(`billid`, `dateofbill`, `grandtotal`, `customerid`, `paymentmode`, `status`, `name`, `mobileno`, `address`,
    // `deliveryboyid`, `remarks`) VALUES ()
    let Query = "INSERT INTO `bill` VALUES(null,'" + date + "','" + grandtotal + "','" + customerid + "','" + paymentmode + "','" + status + "'," +
        "'" + name + "','" + mobile + "','" + address + "',null,'" + remarks + "')";
    // console.log(Query);
    conn.query(Query, (err, result, fields) => {
        if (err) throw err;

        let billid = result.insertId;
        session.billid = billid;

        let cart = [];
        cart = session.cart;

        for (let i = 0; i < cart.length; i++) {
            let itemid = cart[i].itemid;
            let price = cart[i].price;
            let qty = cart[i].qty;
            let partnerid = cart[i].partnerid;

            let amount = price * qty;

            // INSERT INTO `bill_details`(`id`, `billid`, `itemid`, `partnerid`, `price`, `quantity`, `amount`)
            // VALUES ()
            let detailsQuery = "INSERT INTO `bill_details`(`id`, `billid`, `itemid`, `partnerid`, `price`, `quantity`, `amount`)" +
                " VALUES (null," + billid + "," + itemid + "," + partnerid + "," + price + "," + qty + "," + amount + ")";
            // console.log(detailsQuery);
            conn.query(detailsQuery, function (err) {
                if (err) throw err;
            });
        }
        session.cart = undefined;
        session.billid = undefined;
        res.send({status: 'orderPlaced'});
    });
});
//----------------------------------------------------------------------------------------------

// GET CART FROM SERVER
router.get("/Get-Cart-Products-From-Server", (req, res) => {
    let cart = [];

    if (session.cart != undefined) {
        cart = session.cart;
    }

    // Calculate Grand Total
    let total = 0
    for (var i = 0; i <= cart.length - 1; i++) {
        total = total + (cart[i]['price'] * cart[i]['qty'])
    }
    console.log(total);
    session.total = total;

    res.send(JSON.stringify({'cart': cart, 'total': total}));
});
//----------------------------------------------------------------------------------------------

// ADD TO CART Request Handler || +,- Button
router.post('/Add-To-Cart-Selected-Product', async (req, res) => {
    // console.log(req.body);

    let cart = [];
    //--> != undefined means SESSION bana huaa hai.. Empty nahi hai SESSION.
    if (session.cart != undefined) {
        cart = session.cart;
    }

    let action = req.body.action;

    // To ADD Product in CART
    if (action == 'add') {
        // console.log(req.body);
        let P_OBJ = JSON.parse(req.body.product_obj);
        let duplicatePartner = false;

        for (let i = 0; i < cart.length; i++) {
            if (cart[i].partnerid !== P_OBJ.partnerid) {
                // console.log(cart[i].partnerid);
                // console.log(P_OBJ.partnerid);
                duplicatePartner = true;
                break;
            }
        }
        if (duplicatePartner) {
            res.send({status: "otherHotel"});
        } else {
            // let discountedPrice = Math.round(P_OBJ.price - (P_OBJ.price * (P_OBJ.discount / 100)));
            // let grandTotal = Math.round(P_OBJ.qty * discountedPrice);

            let demoCart = {
                "partnerid": P_OBJ.partnerid,
                "categoryid": P_OBJ.categoryid,
                "itemid": P_OBJ.itemid,
                "itemname": P_OBJ.itemname,
                "price": P_OBJ.price,
                // "discountedPrice": discountedPrice,
                "discount": P_OBJ.discount,
                "photo": P_OBJ.photo,
                "itemdescription": P_OBJ.description,
                "status": P_OBJ.status,
                "availabledays": P_OBJ.availabledays,
                "companyname": P_OBJ.companyname,
                "partner_photo": P_OBJ.partner_photo,
                "mobileno": P_OBJ.mobileno,
            };

            //--> To check Current PRODUCT user choose is already Exist or Not in CART.
            let itemid = req.body.productid;
            let isexist = false;
            for (let i = 0; i < cart.length; i++) {
                if (cart[i].itemid == P_OBJ.itemid) {
                    isexist = true;
                    break;
                }
            }
            //--> //To check Current PRODUCT user choose is already Exist or Not in CART.

            // If PRODUCT not exist in Cart.
            if (isexist == false) {
                demoCart.qty = 1;

                cart.push(demoCart);

                session.cart = cart;

                res.send("" + cart.length);
            }
            // If PRODUCT exist (isexist == true) in Cart.
            else {
                let response = {"status": "duplicate"};
                res.send(response);
                // console.log('----- Duplicate -----');
            }
        }

    }
    // To remove(DELETE) Product from CART
    else if (action == 'delete') {
        console.log(req.body);

        let tempcart = [];
        let itemid = req.body.productid;

        for (let i = 0; i < cart.length; i++) {
            if (cart[i].itemid != itemid) {
                tempcart.push(cart[i]);
            }
        }
        console.log(tempcart.length);
        session.cart = tempcart;

        res.send(tempcart);
        // res.send(cart)
        // res.send("" + cart.length);
    }
    // +,- BUTTON working
    else if (action == 'less' || action == 'inc') {
        // console.log(req.body);

        let cart = session.cart;
        let itemid = req.body.productid;
        // let currentstock = await getcurrentstock(productid);

        for (let i = 0; i < cart.length; i++) {
            if (cart[i].itemid == itemid) {

                if (action == 'less') {
                    if (cart[i].qty > 1) {
                        cart[i].qty = cart[i].qty - 1;
                        console.log(cart[i].qty);
                    }
                } else {
                    if (cart[i].qty < 5) {
                        // if (currentstock > cart[i].qty) {
                        cart[i].qty = cart[i].qty + 1;
                        console.log(cart[i].qty);
                        // }
                    }
                }
                break;
            }
        }
        session.cart = cart;

        res.send(cart);
    }
    // CART COUNT
    else if (action == 'getcartcount') {
        // console.log(req.body);

        res.send("" + cart.length);
    }
});
//----------------------------------------------------------------------------------------------

// MY ORDERS
router.post('/userorders', (req, res) => {
    // console.log(req.body);
    let action = req.body.action;
    let UserID = session.UserID;
    let Query = '';

    // MY ORDERS
    if (action == "getmyorders") {
        let AllOrders = [];
        let count2Exit = 1;

        let MainQuery = "SELECT * FROM `bill` WHERE customerid='" + UserID + "' ORDER BY `billid` DESC";
        // console.log(MainQuery);
        conn.query(MainQuery, (err, rows) => {
            if (err) throw err;

            for (let i = 0; i < rows.length; i++) {
                let orderData = rows[i];
                let billid = rows[i].billid;

                let Query = "select bill_details.*,item.itemname from bill_details,item where bill_details.itemid=item.itemid and bill_details.billid=" + billid + " ORDER BY `bill_details`.`billid` DESC";
                // console.log(Query);
                conn.query(Query, function (err, subrows) {
                    if (err) throw err;

                    orderData['details'] = subrows;
                    AllOrders.push(orderData);
                    // count2Exit++;

                    if (count2Exit == rows.length) {
                        res.send(AllOrders);
                    }
                    count2Exit++;
                })
            }
        })
    }
});
//----------------------------------------------------------------------------------------------

// CHANGE PASSWORD
router.post("/userchangepassword", (req, res) => {
    // console.log(req.body);
    let ID = session.UserID;
    let Email = session.UserEmail;
    let currentpassword = req.body.currentpassword;
    let newpassword = req.body.newpassword;

    let MainQuery = "SELECT * FROM `customer` WHERE id='" + ID + "' and email='" + Email + "' and password='" + currentpassword + "'";
    console.log(MainQuery);
    conn.query(MainQuery, function (err, rows) {
        if (err) throw err;

        if (rows.length > 0) {
            // UPDATE `admin` SET `password`=[2] WHERE `email`=[value-1]
            let Query = "UPDATE `customer` SET password='" + newpassword + "' WHERE id='" + ID + "'";
            // console.log(Query);
            conn.query(Query, function (err, rows) {
                if (err) throw err;

                res.send({status: "passwordUpdated"});
            });
        } else {
            res.send({status: "passwordInvalid"});
        }
    });
});

//----------------------------------------------------------------------------------------------

// LOGOUT
router.get('/userlogout', (req, res) => {
    session.UserEmail = undefined;
    session.UserName = undefined;
    session.UserID = undefined;
    // console.log(session.UserName + ' ' + session.UserID);

    res.send({status: "userLogout"});
})
//----------------------------------------------------------------------------------------------

// SESSION
router.get("/usersession", (req, res) => {
    if (session.UserID != undefined && session.UserEmail != undefined && session.UserName != undefined) {
        let response = {"status": session.UserName};
        res.send(response);
    } else {
        let response = {"status": "sessionFailed"};
        res.send(response);
    }
})
//----------------------------------------------------------------------------------------------

// LOGIN
router.post("/userlogin", (req, res) => {
    // console.log(req.body);
    let email = req.body.useremail;
    let password = req.body.password;

    let Query = "SELECT * FROM `customer` WHERE email='" + email + "' and password='" + password + "'";
    // console.log(Query);
    conn.query(Query, function (err, rows) {
        if (err) throw err;

        if (rows.length > 0) {
            session.UserEmail = email;
            session.UserID = rows[0].id;
            session.UserName = rows[0].name;
            // console.log(session.UserName + ' ' + session.UserID);

            res.send({status: "loginSuccess"});
        } else {
            res.send({status: "loginFailed"});
        }
    })
})

//----------------------------------------------------------------------------------------------

// REGISTER
router.post("/usersignup", (req, res) => {
    // console.log(req.body);
    let name = req.body.name;
    let email = req.body.email;
    let password = req.body.password;
    let mobile = req.body.mobile;
    let city = req.body.city;
    let address = req.body.address;
    let status = 1;

    let photo = req.files.photo;
    let filepath = 'user_signup/' + photo.name;
    save_file_on_server(photo, 'user_signup');

    let Query = "SELECT * FROM customer where email='" + email + "' and password='" + password + "' and mobileno='" + mobile + "'";
    conn.query(Query, function (err, rows) {
        if (err) throw err;

        if (rows.length > 0) {
            res.send({status: "userExist"});
        } else {
            // INSERT INTO `customer`(`id`, `name`, `mobileno`, `address`, `photo`, `city`, `email`, `password`, `status`, `otp`)
            // VALUES ()
            let Query = "INSERT INTO `customer` VALUES(null,'" + name + "','" + mobile + "','" + address + "','" + filepath + "','" + city + "'," +
                "'" + email + "','" + password + "','" + status + "',null)";
            // console.log(Query);
            conn.query(Query, function (err) {
                if (err) throw err;

                res.send({status: "registerSuccess"});
            });
        }
    });
});
//----------------------------------------------------------------------------------------------

/* GET users listing. */
router.get('/', function (req, res, next) {
    res.send('respond with a resource');
});

//----------------------------------------------------------------------------------------------

module.exports = router;
