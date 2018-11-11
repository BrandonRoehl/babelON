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
            // window.location.reload();
            Turbolinks.visit(window.location.href);
        }
    }
);