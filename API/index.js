const express = require('express');
const app = express();
const {PythonShell} = require('python-shell')
const PORT = 8080;
const cors = require('cors');
const { json } = require('express');

const { MongoClient, ServerApiVersion, ObjectId } = require('mongodb');
const uri = "mongodb+srv://smdappuser:outofthebox@smd-app.vjnfuva.mongodb.net/chatapp?retryWrites=true&w=majority";
const client = new MongoClient(uri, { useNewUrlParser: true, useUnifiedTopology: true, serverApi: ServerApiVersion.v1 });

var db;
client.connect(err => { db = client.db("chatapp"); console.log('Connected to DB!');});
app.use(express.json({limit: '50mb'}));
//app.use(express.urlencoded({limit: '50mb'}));



app.use (cors( {originn : 'http://192.168.0.105:8080'}))

var server = app.listen(
    PORT,
    () => console.log(`it's alive on http://localhost:${PORT}`)
)

//For Push Notifications
const OneSignal = require('onesignal-node');
// Initialize the OneSignal client
const onesignal = new OneSignal.Client({
    userAuthKey: 'YjJlODIwZTAtMmI4Ny00ZTQxLWFiZWYtYTQyOGVhNTIxYmUz',
    app: {
      appAuthKey: 'MDI4MDI1ZGYtYWQwZC00OGEyLWE1ODctYTI5NTdiNTQ1ZmFi',
      appId: '0bc216ae-c987-4957-aa63-8f697758d0a8'
    }
  });


//Get User
app.post('/getuser', async (req, res) => {
    console.log(req.body.username)
    // console.log(req.body.notificationToeken)
    // pushNotification(req.body.notificationToeken, "Processing your data", "This may take some time")
    let options = {
        scriptPath:"python_scripts",
        args: [req.body.username]
    }
    var script_output;
    PythonShell.run('get_new_user.py', options, (err, resp) => {
        if (err) console.log(err);
        if (resp) console.log(resp);
        console.log(resp);
        var script_output = resp;
        for (let i = 0; i < resp.length; i++)
        {
            if (script_output[i].includes("[!]"))
            {
                script_output.splice(i, 1);
            }
            if (script_output[i].includes("search."))
            {
                script_output.splice(i, 1);
            }
            if (script_output === undefined || script_output.length == 0) {
                script_output = ['notfound'];
            }
        }
        
        res.status(200).send(script_output)
        //res.status(200).send({data: script_output})
    })
    
});

app.post('/getscore', async (req, res) => {
    
    
    let options = {
        scriptPath:"python_scripts",
        args: [req.body.username]
    }
    var script_output;
    PythonShell.run('get_user_assessment.py', options, (err, resp) => {
        if (err) console.log(err);
        if (resp) console.log(resp);
        var script_output = resp;
        for (let i = 0; i < script_output.length; i++)
        {
            if (script_output[i].includes("[!]"))
            {
                script_output.splice(i, 1);
            }
            if (script_output[i].includes("search."))
            {
                script_output.splice(i, 1);
            }
            // if (script_output[i].includes("/"))
            // {
            //     script_output.splice(i, 1);
            //     i = 0;
            // }
        }
        
        res.status(200).send(script_output)
        //res.status(200).send({data: script_output})
        
    })
    
});

app.post('/uploadImage', async (req, res) => {

    console.log("im here")
    try
    {
        console.log(req);
        var _uid = req.body.uid;
        var _profileImage = req.body.profileImage;

 
        
        var data = {uid: _uid, profileImage: _profileImage}
        //var updateDb = {$set: {number: 12}}

        db.collection("DPS").insertOne(data, function(err, _res)
        {
            if (err) 
            {
                console.log("Error");
                throw err;
            }
            console.log("_______________________________________________________________________________________________________________")
            
            res.status(200).send({'status': 1});
        });       
    }
    catch(error)
    {
        console.log(error);
        res.send("Error! Failed to upload image.")
    }
});

//Get dp
app.post('/getdp', async (req, res) => {
    try
    {
        var _uid = req.body.uid;
        var _targetUid = req.body.targetUid;



        // db.collection('users').findOne({email: _email}, { projection: {hashPassword: 1} }, function(err, _res) {
        db.collection('DPS').findOne({uid: _uid}, function(err, _res) {
            if (err) throw err;
            console.log(_res);
            var payload = {profileImage: _res['profileImage'], status: 1}
            res.send(payload);

        });
    }
    catch(error)
    {
        console.log(error);
        res.send("Error! Failed to login user.")
    }
});

function pushNotification(playerId, title, body)
{
    // Set up the notification
    const notification = new OneSignal.Notification({
        headings: {
        en: title
        },
        contents: {
        en: body
        }
    });
    
    // Set the recipient of the notification
    notification.setTargeting('player_id', playerId);
    
    // Send the notification
    onesignal.sendNotification(notification, (err, httpResponse, data) => {
        if (err) {
        console.error('Error:', err);
        return;
        }
    
        console.log('Notification sent successfully:', data);
    });
}

server.timeout = 240000