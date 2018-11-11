
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
            $("#messages").load(location.href+" #messages>*","", function () {
                $('#messages').scrollTop($('#messages')[0].scrollHeight - $('#messages')[0].clientHeight);
            });
            console.log("received");
        }
    }
);
