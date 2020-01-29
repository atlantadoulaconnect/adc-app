const functions = require('firebase-functions');
const admin = require('firebase-admin');
const nodemailer = require('nodemailer');

admin.initializeApp();
require('dotenv').config()

const {SENDER_EMAIL,SENDER_PASSWORD} = process.env;

exports.sendEmail = functions.https.onCall((data, context) => {
    let authData = nodemailer.createTransport({
        host:'smtp.gmail.com',
        port: 465,
        secure: true,
        auth: {
            user:SENDER_EMAIL,
            pass:SENDER_PASSWORD
        }
    });
    authData.sendMail({
        from: 'no-reply@atlantadoulaconnect.org',
        to: `${data.email}`,
        subject: `${data.subject}`,
        text:`${data.message}`,
        html: `${data.message}`,
    }).then(res => console.log('Successfully sent email.')).catch(err => console.log(err));
});
