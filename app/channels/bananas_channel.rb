class BananasChannel < ApplicationCable::Channel
    def subscribed
        stream_from 'bananas'
    end
end
