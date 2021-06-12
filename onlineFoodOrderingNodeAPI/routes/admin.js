const express = require('express');
const router = express.Router();

const query = require('querystring');
const session = require('express-session');
const nodemailer = require('nodemailer');

//----------------------------------------------------------------------------------------------
//  --* Connection Module *--
var conn = require('../connection');
//  --* File Upload Module *--
const save_file_on_server = require('../uploadfile');
//----------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------


//----------------------------------------------------------------------------------------------

//----------------------------------------------------------------------------------------------


// ORDERS
router.post("/manageorder", (req, res) => {
    // console.log(req.body);
    let action = req.body.action;

    // Get All Orders + Orders Details
    if (action == 'getAllOrders') {
        let AllOrders = [];
        let count2Exit = 1;

        let MainQuery = "select DISTINCT bill.* from bill,bill_details where bill.billid=bill_details.billid order by bill.billid DESC";
        // console.log(MainQuery);
        conn.query(MainQuery, function (err, rows) {
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
                    if (count2Exit == rows.length) {
                        res.send(AllOrders);
                    }
                    count2Exit++;
                })
            }
        })
    }
    // Get Today's Orders + Orders Details
    else if (action == 'getTodaysOrders') {
        let TodaysOrders = [];
        let count2Exit = 1;

        let today = new Date();
        let currentDate = (today.getFullYear() + '-' + (today.getMonth() + 1) + '-' + today.getDate());

        let MainQuery = "select DISTINCT bill.*,partnertable.companyname from bill,bill_details,partnertable where bill.billid=bill_details.billid and partnertable.partnerid=bill_details.partnerid and bill.dateofbill='" + currentDate + "' order by bill.billid DESC"
        // console.log(MainQuery);
        conn.query(MainQuery, function (err, rows) {
            if (err) throw err;

            for (let i = 0; i < rows.length; i++) {
                let orderData = rows[i];
                let billid = rows[i].billid;

                let Query = "select bill_details.*,item.itemname from bill_details,item where bill_details.itemid=item.itemid and bill_details.billid=" + billid + " ORDER BY `bill_details`.`billid` DESC";
                // console.log(Query);
                conn.query(Query, function (err, subrows) {
                    if (err) throw err;

                    orderData['details'] = subrows;
                    TodaysOrders.push(orderData);

                    if (count2Exit == rows.length) {
                        res.send(TodaysOrders);
                    }
                    count2Exit++;
                })
            }
        })
    }
})

//----------------------------------------------------------------------------------------------

// PARTNER
router.post("/managepartner", (req, res) => {
    console.log(req.body);
    let action = req.body.action;

    // Get Active Partner
    if (action == 'getUnblockedPartner') {
        let Query = "select * from partnertable where status!='0' order by partnerid DESC";
        conn.query(Query, function (err, rows) {
            if (err) throw err;

            res.send(rows);
        })
    }
    // update partner status
    else if (action == 'partner') {
        let partnerid = req.body.partnerid;
        let status = req.body.status;
        let Query;

        if (status == 2) {
            Query = "update partnertable set status='0' where partnerid='" + partnerid + "'";
            conn.query(Query, function (err) {
                if (err) throw err;

                res.send({status: 'partnerBlocked'});
            })
        } else if (status == 3) {
            Query = "update partnertable set status='1' where partnerid='" + partnerid + "'";
            conn.query(Query, function (err) {
                if (err) throw err;

                res.send({status: 'partnerActivated'});
            })
        } else {
            Query = "update partnertable set status='" + status + "' where partnerid='" + partnerid + "'";
            conn.query(Query, function (err) {
                if (err) throw err;

                if (status == 1) {
                    res.send({status: 'partnerAccepted'});
                } else {
                    res.send({status: 'partnerRejected'});
                }
            })
        }
    }
    // Get Blocked Partner
    else if (action == 'getBlockedPartner') {
        let Query = "select * from partnertable where status='0' order by partnerid DESC";
        conn.query(Query, function (err, rows) {
            if (err) throw err;

            res.send(rows);
        })
    }
})

//----------------------------------------------------------------------------------------------

// CATEGORY
router.post('/managecategory', (req, res) => {
    // console.log(req.body);
    let action = req.body.action;
    let Query = '';

    // ADD
    if (action == "add") {
        let Category = JSON.parse(req.body.categoryOBJ);

        // INSERT INTO `categories`(`categoryid`, `categoryname`, `description`) VALUES ([1],[2],[3])
        Query = "INSERT INTO `categories` VALUES(null,'" + Category.categoryname + "','" + Category.categorydescriptiopn + "')";
        // console.log(Query);
        conn.query(Query, (err) => {
            if (err) throw err;

            res.send({status: 'categoryAdded'});
        })
    }
    // VIEW
    else if (action == "view") {
        Query = "SELECT * FROM `categories` ORDER BY `categories`.`categoryid` DESC";
        // console.log(Query);
        conn.query(Query, (err, rows) => {
            if (err) throw err;

            res.send(rows);
        })
    }
    // DELETE
    else if (action == "delete") {
        let CatID = JSON.parse(req.body.CatID);

        // DELETE FROM `category` WHERE
        Query = "DELETE FROM `categories` WHERE categoryid='" + CatID + "'";
        console.log(Query);
        conn.query(Query, (err) => {
            if (err) throw err;

            res.send({status: 'categoryDeleted'});
        })
    }
    // UPDATE
    else {
        let Cat = JSON.parse(req.body.categoryOBJ);

        // UPDATE `category` SET `categoryid`=[1],`categoryname`=[2],`description`=[3] WHERE
        Query = "UPDATE `categories` SET `categoryname`='" + Cat.categorynameEdit + "',`description`='" + Cat.categorydescriptiopnEdit + "' WHERE `categoryid`='" + Cat.categoryid + "'";
        // console.log(Query);
        conn.query(Query, (err) => {
            if (err) throw err;

            res.send({status: 'categoryUpdated'});
        })
    }
});

//----------------------------------------------------------------------------------------------

// LOGOUT
router.get('/adminlogout', (req, res) => {
    session.AdminEmail = undefined;
    session.AdminName = undefined;

    let response = {"status": "adminLogout"};
    res.send(response);
})
//----------------------------------------------------------------------------------------------

// CHANGE PASSWORD
router.post("/adminchangepassword", (req, res) => {
    console.log(req.body);
    let email = session.AdminEmail;
    let currentpassword = req.body.currentpassword;
    let newpassword = req.body.newpassword;

    let MainQuery = "SELECT * FROM `admin` WHERE email='" + email + "' and password='" + currentpassword + "'";
    console.log(MainQuery);
    conn.query(MainQuery, function (err, rows) {
        if (err) throw err;

        if (rows.length > 0) {
            // UPDATE `admin` SET `password`=[2] WHERE `email`=[value-1]
            let Query = "UPDATE `admin` SET password='" + newpassword + "' WHERE email='" + email + "'";
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

// SESSION
router.get("/adminsession", (req, res) => {
    if (session.AdminEmail != undefined) {
        let response = {"status": session.AdminName};
        res.send(response);
    } else {
        let response = {"status": "sessionFailed"};
        res.send(response);
    }
})

//----------------------------------------------------------------------------------------------

// LOGIN
router.post("/adminlogin", (req, res) => {
    // console.log(req.body);
    let adminemail = req.body.adminemail;
    let password = req.body.password;

    let Query = "SELECT * FROM admin where email='" + adminemail + "' and password='" + password + "'";
    conn.query(Query, function (err, rows) {
        if (err) throw err;

        if (rows.length > 0) {
            session.AdminEmail = adminemail;
            session.AdminName = rows[0].name;
            let response = {"status": "loginSuccess"};
            res.send(response);
            // res.send(JSON.stringify(rows[0].name));
        } else {
            let response = {"status": "loginFailed"};
            res.send(response);
        }
    })
})
//----------------------------------------------------------------------------------------------

/* GET home page. */
router.get('/', function (req, res, next) {
    res.render('index', {title: 'Express'});
});
// ----------------------------------------------------------------------------------------------

module.exports = router;
