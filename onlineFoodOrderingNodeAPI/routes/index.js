var express = require('express');
var router = express.Router();

const session = require('express-session');
//----------------------------------------------------------------------------------------------
//  --* Connection Module *--
var conn = require('../connection');
//  --* File Upload Module *--
const save_file_on_server = require('../uploadfile');
//----------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------

/* SEARCH (ITEM) */
router.post('/search', function (req, res) {
    // console.log(req.body);
    let action = req.body.action;
    let SearchItem = JSON.parse(req.body.I);
    // console.log(SearchItem);
    // console.log(SearchItem.itemname);
    let Query = '';

    // search Item
    if (action === 'searchItem') {
        Query = "SELECT item.*,partnertable.companyname,partnertable.photo as partner_photo,partnertable.mobileno,partnertable.opentime,partnertable.closetime FROM item INNER JOIN partnertable ON item.partnerid=partnertable.partnerid WHERE item.itemname LIKE '%" + SearchItem.itemname + "%'";
        // console.log(Query);
        conn.query(Query, (err, rows) => {
            if (err) throw err;

            res.send(rows);
        });
    }
    // Get Partner
    else if (action === 'getPartner') {
        Query = "SELECT * FROM `partnertable` WHERE partnerid='" + SearchItem + "'";
        // console.log(Query);
        conn.query(Query, (err, rows) => {
            if (err) throw err;

            res.send(rows);
        });
    }
    // search Partner
    else {
        Query = "SELECT * FROM `partnertable` WHERE companyname LIKE '%" + SearchItem.partnername + "%'";
        // console.log(Query);
        conn.query(Query, (err, rows) => {
            if (err) throw err;

            res.send(rows);
        });
    }
});
//----------------------------------------------------------------------------------------------

/* GET home page. */
router.get('/', function (req, res, next) {
    res.render('index', {title: 'Express'});
});

module.exports = router;
