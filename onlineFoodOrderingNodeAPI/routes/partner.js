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

// CONFIRMED ORDERS
router.post("/confirm-orders", async (req, res) => {
    console.log(req.body);
    let ID = session.PartnerID;
    let action = req.body.action;
    let Query = '';

    // PARTNER CONFIRMED ORDERS
    if (action == 'getconfirmedorders') {
        let AllOrders = [];
        let count2Exit = 1;

        Query = "select DISTINCT bill.* from bill,bill_details where bill.billid=bill_details.billid and bill_details.partnerid='" + ID + "' and (bill.status='Confirmed' or bill.status='Dispatched') order by billid DESC";
        // console.log(Query);
        await conn.query(Query, (err, rows) => {
            if (err) throw err;

            // rows.length == 0
            if (rows.length == 0) {
                res.send(AllOrders)
            }
            // rows.length > 0
            else {
                // console.log(rows.length);
                for (let i = 0; i < rows.length; i++) {
                    let orderData = rows[i];
                    let billid = rows[i].billid;

                    let SubQuery = "select bill_details.*,item.itemname from bill_details,item where bill_details.itemid=item.itemid and bill_details.billid='" + billid + "'";
                    // console.log(SubQuery);
                    conn.query(SubQuery, function (err, subrows) {
                        if (err) throw err;

                        orderData['details'] = subrows;
                        AllOrders.push(orderData);


                        // let SubQuery2 = "select * from deliveryboywork where orderid='" + billid + "' order by id DESC";
                        // conn.query(SubQuery2, function (err, subrows2) {
                        //     if (err) throw err;
                        //     orderData['deliveryboydetails'] = subrows2;
                        //     AllOrders.push(orderData);
                        // });

                        if (count2Exit == rows.length) {
                            res.send(AllOrders);
                        }
                        count2Exit++;
                    })
                }
            }
        });
    }
    // CHANGE STATUS in bill & delivery_boy_work TABLE
    else if (action == 'changestatus') {
        let O_ID = req.body.Order_ID;
        let B_ID = req.body.Boy_ID;
        let Status = req.body.Status;

        // date & time --> Javascript
        let currentDate = new Date();
        let cDay = currentDate.getDate();
        let cMonth = currentDate.getMonth() + 1;
        let cYear = currentDate.getFullYear();

        let date = cYear + '-' + cMonth + '-' + cDay;
        let time = currentDate.getHours() + ':' + currentDate.getMinutes() + ':' + currentDate.getSeconds();
        // console.log(date);
        // console.log(time);

        let OtherQuery = "SELECT id,orderid FROM `deliveryboywork` where orderid='" + O_ID + "'";
        // console.log(OtherQuery);
        conn.query(OtherQuery, (err, rows) => {
            if (err) throw err;

            // order_id != ''
            if (rows.length > 0) {
                let DB_Work_ID = rows[0].id;

                // UPDATE `deliveryboywork` SET `boyid`=[value-2],`orderid`=[value-3],`status`=[value-4],`date`=[value-5],`time`=[value-6] WHERE `id`=[value-1]
                Query = "UPDATE deliveryboywork SET `status`='" + Status + "',`date`='" + date + "',`time`='" + time + "' WHERE `id`='" + DB_Work_ID + "'";
                // console.log(Query);
                conn.query(Query, (err) => {
                    if (err) throw err;

                    if (!err) {
                        let SubQuery = "update bill set status='" + Status + "' where billid='" + O_ID + "'";
                        // console.log(SubQuery);
                        conn.query(SubQuery, (err) => {
                            if (err) throw err;

                            res.send({status: 'statusUpdated'});
                            console.log('----- EXIST -----');
                        });
                    }
                });
            }
            // order_id == ''
            else {
                // INSERT INTO `deliveryboywork`(`id`, `boyid`, `orderid`, `status`, `date`, `time`) VALUES ()
                Query = "INSERT INTO deliveryboywork VALUES(null,'" + B_ID + "','" + O_ID + "','" + Status + "','" + date + "','" + time + "')";
                // console.log(Query);
                conn.query(Query, (err) => {
                    if (err) throw err;

                    if (!err) {
                        let SubQuery = "update bill set status='" + Status + "' where billid='" + O_ID + "'";
                        // console.log(SubQuery);
                        conn.query(SubQuery, (err) => {
                            if (err) throw err;

                            res.send({status: 'statusUpdated'});
                            console.log('----- NOT EXIST -----');
                        });
                    }
                });
            }
        });
    }
});
//----------------------------------------------------------------------------------------------

// PENDING ORDERS
router.post("/pending-orders", (req, res) => {
    console.log(req.body);
    let ID = session.PartnerID;
    let action = req.body.action;
    let Query = '';

    // PARTNER PENDING ORDERS
    if (action == 'getpendingorders') {
        let AllOrders = [];
        let count2Exit = 1;

        Query = "select DISTINCT bill.* from bill,bill_details where bill.billid=bill_details.billid and bill_details.partnerid='" + ID + "' and bill.status='Pending' order by bill.billid DESC";
        // console.log(Query);
        conn.query(Query, (err, rows) => {
            if (err) throw err;

            if (rows.length == 0) {
                res.send(AllOrders)
            } else {
                for (let i = 0; i < rows.length; i++) {
                    let orderData = rows[i];
                    let billid = rows[i].billid;

                    let SubQuery = "select bill_details.*,item.itemname from bill_details,item where bill_details.itemid=item.itemid and bill_details.billid='" + billid + "'";
                    // console.log(SubQuery);
                    conn.query(SubQuery, function (err, subrows) {
                        if (err) throw err;

                        orderData['details'] = subrows;
                        AllOrders.push(orderData);
                        if (count2Exit == rows.length) {
                            res.send(AllOrders);
                        }
                        count2Exit++;
                    })
                }
            }
        })
    }
    // DELIVERY BOY
    else if (action == "getDeliveryBoy") {
        Query = "SELECT deliveryboy.deliveryid,deliveryboy.name FROM `deliveryboy` WHERE partnerid='" + ID + "'";
        // console.log(Query);
        conn.query(Query, (err, rows) => {
            if (err) throw err;

            res.send(rows);
        })
    }
    // REJECT ORDER
    else if (action == "reject") {
        let O_ID = req.body.Order_ID;
        let status = 'Rejected';

        Query = "update bill set status='" + status + "' where billid='" + O_ID + "'";
        console.log(Query);
        conn.query(Query, (err) => {
            if (err) throw err;

            res.send({status: 'orderRejected'});
        })
    }
    // CONFIRM ORDER
    else if (action == "confirm") {
        let O_ID = req.body.Order_ID;
        let DBoy_ID = req.body.DBoy_ID;
        let status = 'Confirmed';

        Query = "update bill set status='" + status + "',deliveryboyid='" + DBoy_ID + "' where billid='" + O_ID + "'";
        console.log(Query);
        conn.query(Query, (err) => {
            if (err) throw err;

            res.send({status: 'orderConfirmed'});
        })
    }
});
//----------------------------------------------------------------------------------------------

// DELIVERY BOY
router.post("/manage-delivery-boy", (req, res) => {
    // console.log(req.body);
    let ID = session.PartnerID;
    let action = req.body.action;
    let Query = '';

    // ADD
    if (action == 'add') {
        let DB = JSON.parse(req.body.DBoyOBJ);

        let photo = req.files.photo;
        let filepath = 'delivery_boy/' + photo.name;
        save_file_on_server(photo, 'delivery_boy');

        // INSERT INTO `deliveryboy`(`deliveryid`, `name`, `mobileno`, `address`, `photo`, `partnerid`, `starttime`, `endtime`)
        // VALUES ()
        Query = "INSERT INTO `deliveryboy` VALUES (null,'" + DB.dBoyName + "','" + DB.mobile + "','" + DB.address + "','" + filepath + "'," +
            "'" + ID + "','" + DB.startTime + "','" + DB.endTime + "')";
        // console.log(Query);
        conn.query(Query, (err) => {
            if (err) throw err;

            res.send({status: 'DBoyAdded'});
        })
    }
    // VIEW
    else if (action == "view") {
        Query = "SELECT * FROM `deliveryboy` WHERE partnerid='" + ID + "' ORDER BY `deliveryboy`.`deliveryid` DESC";
        console.log(Query);
        conn.query(Query, (err, rows) => {
            if (err) throw err;

            res.send(rows);
        })
    }
    // DELETE
    else if (action == "delete") {
        let ID = req.body.ID;

        Query = "DELETE FROM `deliveryboy` WHERE deliveryid='" + ID + "'";
        // console.log(Query);
        conn.query(Query, (err) => {
            if (err) throw err;

            res.send({status: 'DBoyDeleted'});
        })
    }
    // UPDATE
    else {
        let DB = JSON.parse(req.body.DBoyOBJ);

        let filepath = '';
        if (req.files != null) {
            let photo = req.files.photo;
            filepath = 'delivery_boy/' + photo.name;
            save_file_on_server(photo, 'delivery_boy');
        }
        let SubQuery = '';
        if (filepath != '') {
            SubQuery = ",photo='" + filepath + "'";
        }

        // UPDATE `deliveryboy` SET `name`=[2],`mobileno`=[3],`address`=[4],`photo`=[5],`partnerid`=[6],`starttime`=[7],
        // `endtime`=[8] WHERE `deliveryid`=[1]
        Query = "UPDATE `deliveryboy` SET `name`='" + DB.dBoyNameEdit + "',`mobileno`='" + DB.mobileEdit + "'," +
            "`address`='" + DB.addressEdit + "'" + SubQuery + ",`partnerid`='" + ID + "',`starttime`='" + DB.startTimeEdit + "'," +
            "`endtime`='" + DB.endTimeEdit + "' WHERE `deliveryid`='" + DB.dBoyID + "'";
        // console.log(Query);
        conn.query(Query, (err) => {
            if (err) throw err;

            res.send({status: 'DBoyUpdated'});
        })
    }
});
//----------------------------------------------------------------------------------------------

// ITEM
router.post("/manage-item", (req, res) => {
    console.log(req.body);
    let ID = session.PartnerID;
    let action = req.body.action;
    let Query = '';

    // ADD
    if (action == 'add') {
        let I = JSON.parse(req.body.ItemOBJ);
        let Days = req.body.Days;

        let photo = req.files.photo;
        let filepath = 'item_pics/' + photo.name;
        save_file_on_server(photo, 'item_pics');

        let MainQuery = "SELECT * FROM item where itemname='" + I.itemname + "' and partnerid='" + ID + "'";
        // console.log(MainQuery);
        conn.query(MainQuery, (err, rows) => {
            if (err) throw err;

            if (rows.length > 0) {
                res.send({status: 'itemExist'});
            } else {
                // INSERT INTO `item`(`itemid`, `itemname`, `price`, `description`, `categoryid`, `photo`, `partnerid`, `status`,
                // `availabledays`) VALUES ()
                Query = "INSERT INTO `item` VALUES (null,'" + I.itemname + "','" + I.price + "','" + I.description + "','" + I.categoryid + "'," +
                    "'" + filepath + "','" + ID + "','" + 1 + "','" + Days + "')";
                // console.log(Query);
                conn.query(Query, (err, rows) => {
                    if (err) throw err;

                    res.send({status: 'itemAdded'});
                });
            }
        })
    }
    // GET CATEGORY
    else if (action == "getcategory") {
        Query = "SELECT * FROM `categories` ORDER BY `categories`.`categoryname` ASC";
        // Query = "SELECT * FROM `categories` ORDER BY `categories`.`categoryid` DESC";
        // console.log(Query);
        conn.query(Query, (err, rows) => {
            if (err) throw err;

            res.send(rows);
        })
    }
    // VIEW
    else if (action == "view") {
        Query = "SELECT item.*,categories.categoryname FROM `item` INNER JOIN categories ON item.categoryid=categories.categoryid WHERE partnerid='" + ID + "' ORDER BY `item`.`itemid` DESC";
        // console.log(Query);
        conn.query(Query, (err, rows) => {
            if (err) throw err;

            res.send(rows);
        })
    }
    // DELETE
    else if (action == "delete") {
        let ItemID = req.body.ItemID;

        Query = "DELETE FROM `item` WHERE itemid='" + ItemID + "'";
        // console.log(Query);
        conn.query(Query, (err) => {
            if (err) throw err;

            res.send({status: 'itemDeleted'});
        })
    }
    // UPDATE
    else {
        let I = JSON.parse(req.body.ItemOBJ);

        let filepath = '';
        if (req.files != null) {
            let photo = req.files.photo;
            filepath = 'item_pics/' + photo.name;
            save_file_on_server(photo, 'item_pics');
        }
        let SubQuery = '';
        if (filepath != '') {
            SubQuery = ",photo='" + filepath + "'";
        }

        // UPDATE `item` SET `itemname`=[value-2],`price`=[value-3],`description`=[value-4],
        // `categoryid`=[value-5],`photo`=[value-6],`partnerid`=[value-7],`status`=[value-8],`availabledays`=[value-9]
        // WHERE `itemid`=[value-1]
        Query = "UPDATE `item` SET `itemname`='" + I.itemnameEdit + "',`price`='" + I.priceEdit + "',`description`='" + I.descriptionEdit + "'," +
            "`categoryid`='" + I.categoryidEdit + "'" + SubQuery + " WHERE `itemid`='" + I.itemID + "'";
        console.log(Query);
        conn.query(Query, (err, rows) => {
            if (err) throw err;

            res.send({status: 'itemUpdated'});
        });
    }
});
//----------------------------------------------------------------------------------------------

// CHANGE PASSWORD
router.post("/partnerchangepassword", (req, res) => {
    // console.log(req.body);
    let ID = session.PartnerID;
    let Email = session.PartnerEmail;
    let currentpassword = req.body.currentpassword;
    let newpassword = req.body.newpassword;

    let MainQuery = "SELECT * FROM `partnertable` WHERE partnerid='" + ID + "' and email='" + Email + "' and password='" + currentpassword + "'";
    console.log(MainQuery);
    conn.query(MainQuery, function (err, rows) {
        if (err) throw err;

        if (rows.length > 0) {
            // UPDATE `partnertable` SET `password`=[2] WHERE `partnerid`=[1]
            let Query = "UPDATE `partnertable` SET password='" + newpassword + "' WHERE partnerid='" + ID + "'";
            console.log(Query);
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
router.get('/partnerlogout', (req, res) => {
    session.PartnerID = undefined;
    session.PartnerEmail = undefined;
    session.PartnerCompanyName = undefined;
    // console.log(session.PartnerCompanyName + ' ' + session.PartnerID);

    res.send({status: "partnerLogout"});
})
//----------------------------------------------------------------------------------------------

// SESSION
router.get("/partnersession", (req, res) => {
    if (session.PartnerID != undefined && session.PartnerEmail != undefined && session.PartnerCompanyName != undefined) {
        res.send({status: session.PartnerCompanyName});
    } else {
        res.send({status: "sessionFailed"});
    }
})
//----------------------------------------------------------------------------------------------

// LOGIN
router.post("/partnerlogin", (req, res) => {
    // console.log(req.body);
    let email = req.body.partneremail;
    let password = req.body.password;

    let Query = "SELECT * FROM `partnertable` WHERE email='" + email + "' and password='" + password + "'";
    // console.log(Query);
    conn.query(Query, function (err, rows) {
        if (err) throw err;

        if (rows.length > 0) {
            if (rows[0].status === 2) {
                res.send({serverresponse: "notApproved"});
            } else {
                session.PartnerEmail = email;
                session.PartnerCompanyName = rows[0].companyname;
                session.PartnerID = rows[0].partnerid;
                // console.log(session.PartnerCompanyName + ' ' + session.PartnerID);

                res.send({serverresponse: "loginSuccess"});
            }
        } else {
            res.send({serverresponse: "loginFailed"});
        }
    })
})
//----------------------------------------------------------------------------------------------

// REGISTER
router.post("/partnersignup", (req, res) => {
    // console.log(req.body);
    let companyname = req.body.companyname;
    let ownername = req.body.ownername;
    let email = req.body.email;
    let mobile = req.body.mobile;
    let password = req.body.password;
    let address = req.body.address;
    let location = req.body.location;
    let city = req.body.city;
    let opening = req.body.opening;
    let closing = req.body.opening;
    let status = 2;

    let photo = req.files.photo;
    let filepath = 'partner_signup/' + photo.name;
    save_file_on_server(photo, 'partner_signup');

    let Query = "SELECT * FROM partnertable where companyname='" + companyname + "'";
    // console.log(Query);
    conn.query(Query, function (err, rows) {
        if (err) throw err;

        if (rows.length > 0) {
            console.log("userExist");
            res.send({status: "userExist"});
        } else {
            // INSERT INTO `partnertable`(`partnerid`, `companyname`, `ownername`, `photo`, `mobileno`, `address`, `city`, `email`,
            // `password`, `location`, `status`, `opentime`, `closetime`) VALUES ()
            let Query = "INSERT INTO `partnertable` VALUES(null,'" + companyname + "','" + ownername + "','" + filepath + "','" + mobile + "'," +
                "'" + address + "','" + city + "','" + email + "','" + password + "','" + location + "','" + status + "','" + opening + "'," +
                "'" + closing + "')";
            // console.log(Query);
            conn.query(Query, function (err) {
                if (err) throw err;

                // console.log("registerSuccess");
                res.send({status: "registerSuccess"});
            });
        }
    });
});
//----------------------------------------------------------------------------------------------
module.exports = router;
