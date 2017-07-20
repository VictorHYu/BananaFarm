// app/assets/javascripts/channels/bananas.js

//= require cable
//= require_self
//= require_tree .

App.players = App.cable.subscriptions.create('BananasChannel', {
                received: function(data) {
                    if (data.action == 'increment')
                    {
                        var value_id = '#length_id_' + data.id;
                        $(value_id).html(parseInt($(value_id).html(), 10)+1)
                    }
                    if (data.action == 'sell')
                    {
                        var value_id = '#length_id_' + data.id;
                        $(value_id).html(0)
                    }
                },

                returnAction: function(data) {
                    return data.action;
                    }
                });
