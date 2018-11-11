App.cable.subscriptions.create(
    {
        channel: "ChatChannel", id: "1"
    },

    {
        connected: function () {
            console.log("connected");
        },

        disconnected: function () {
            console.log("disconnected");
        },

        rejected: function () {
            console.log("rejected");
        },

        received: function (data) {
            console.log("received");
            if Turbolinks.supported {
                Turbolinks.visit(window.location.href);
            } else {
                window.location.reload();
            }
            window.scrollTo(0,document.body.scrollHeight);
        }
    }
);
