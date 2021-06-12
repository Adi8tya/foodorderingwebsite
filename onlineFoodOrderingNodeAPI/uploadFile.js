function save_file_on_server(file1, foldername) {
    let filename = file1.name;
    // console.log(filename);
    var pathoffileupload = foldername + '/' + filename;
    var realpath = 'public/' + pathoffileupload;
    // console.log('Real upload path : '+realpath);

    file1.mv(realpath, function (err) {
        if (err)
            res.status(500).send(err);

        // console.log(filename+' received at server !!!');
    });
}

module.exports = save_file_on_server;