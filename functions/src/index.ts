import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
admin.initializeApp();

const db = admin.firestore();
const fcm = admin.messaging();

export const newApplication = functions.firestore
    .document('applications/{applicationId}')
    .onCreate(async snapshot => {
        const app = snapshot.data();
        const querySnapshot = await db
            .collection('users')
            .doc('pu4Q1r0eG2UFh2FWgMRrM0TGfq32')
            .collection('tokens')
            .get();
        const tokens = querySnapshot.docs.map(snap => snap.id);

        const payload: admin.messaging.MessagingPayload = {
            notification: {
                title: "New Application",
                // body: `${app.name} has submitted a new application. Open to view the application.`,
                body: `Jane Doe has submitted a new application. Open to view the application.`,
                clickAction: 'FLUTTER_NOTIFICATION_CLICK',
            }
        };

        return fcm.sendToDevice(tokens, payload);
    });