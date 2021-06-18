//jshint esversion:7
const express = require("express");
const bodyParser = require("body-parser");
const app = express();
const mongoose = require("mongoose");
const cors = require("cors");
const multer = require("multer");
const { sqrt } = require("mathjs");
const storage = multer.diskStorage({
  destination: function(req,file,cb) {
    callBack(null,"./images/");  },
  filename: function(req,file,cb) {
     callBack(null,new Date().toISOString() + file.originalname);}});
const upload = multer({
  storage: storage
  });
app.use(express.json({
limit: '2mb'
}));
app.use(
  bodyParser.urlencoded({
  extended: true
}));
app.disable('etag');
mongoose.set('useNewUrlParser', true);
const uri = "mongodb+srv://Jason:Harmonymane7@cluster0-ztkec.mongodb.net/UserInfo?retryWrites=true&w=majority";
mongoose.connect(uri || "/localhost:3000", {
      useNewUrlParser: true,
      useCreateIndex: true,
      useUnifiedTopology: true
    }).then(res=>{
            console.log("DB Connected!");
    }).catch(err => {
      console.log(Error, err.message);
    });
mongoose.connection.on("connected" , () => {
    console.log(
      "We are connected to atlas now"
    );
  });
mongoose.connection.off("not connected", () => {
  console.log(
    "We are not connected to atlas" );
  });
var infoSchema = new mongoose.Schema({
Email: String,
Username: String,
JobDescription: String,
Image: String,
PhoneNumber: Number,
locationLatitude: Number,
locationLongitude: Number,
Worker: Boolean,
Active: Boolean});
const Info = mongoose.model("Info", infoSchema);
app.post("/posting",cors(),upload.single('Image'),function (req,res){
  Info.find({}, function (e,R) {
    var DISTANCE = 0;
    const USERLOCATION = {
      latitude: req.body['locationLatitude'],
      longitude:req.body['locationLongitude']};
  if (e != null) {console.log(e);}
  else {console.log("JSON resluts: "+ R);
   DISTANCE = sqrt(((USERLOCATION['longitude'] + R['longitude']) ** 2) - ((USERLOCATION['latitude'] + R['latitude']) ** 2));
   if (DISTANCE < 50 && req.body['active'] == true && req.body['worker'] == true) {
        console.log("A client will be sent");
      }
   else if (DISTANCE < 50 && req.boduy['active'] == true && req.body['worker'] == false) {
        console.log("A worker will be sent"); }
   else {
        console.log("There is an Error");}
 }});
});
app.get("/getting",cors(),upload.single('Image'), function (req,res){
  res.send({"message": "Hello phone I'm from the servery server!!!!!!!  :) getting"});
  const info = new Info({
  Email : req.body['email'],
  Username : req.body['username'],
  JobDescription: req.body['JobDescription'],
  Image: req.body['Image'],
  PhoneNumber: req.body['PhoneNumber'],
  locationLatitude: req.body['locationLatitude'],
  locationLongitude: req.body['locationLongitude'],
  Worker: req.body['worker'],
  Active: req.body['active']});
  info.save(function(e){
    if (!e) {
      console.log("Cannot save data (e): " + e);
    } else {
      console.log("hello from get");
      console.log("saved");}});
  if (req.body['worker'] == false) {
   console.log("This is a client");  }
  else if (req.body['worker'] == true) {
   console.log("This is a worker");}
  var DISTANCE = 0;
  const USERLOCATION = {
    latitude: req.body['locationLatitude'],
    longitude:req.body['locationLongitude']};
  console.log(req.body);
});
app.patch("/", function (req,res) {
});
let port = process.env.PORT;
if (port == null || port == "") {
  port = 3000;
}
app.listen(port, function () {
  console.log("started servery server");
});
