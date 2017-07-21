// app/assets/javascripts/channels/bananas.js

//= require cable
//= require_self
//= require_tree .

App.players = App.cable.subscriptions.create('BananasChannel', {
                received: function(data) {
                    if (data.action == 'increment')
                    {
                        // Add to banana amount
                        var value_id = '#length_id_' + data.id;
                        $(value_id).html(parseInt($(value_id).html(), 10)+1)
                    }
                    if (data.action == 'sell')
                    {
                        // Reset banana amount
                        var value_id = '#length_id_' + data.id;
                        $(value_id).html(0)
                               
                        // Add to coins amount
                        var coins = '#coins_amount'
                        $(coins).html(parseInt($(coins).html(), 10) +
                                      parseInt(data.coins))
                    }
                },

                returnAction: function(data) {
                    return data.action;
                    }
                });
