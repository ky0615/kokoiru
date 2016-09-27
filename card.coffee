pafe = require "libpafe"
pasori = new pafe.Pasori()

class Card
    idmCache = "a"

    readCard: =>
        # console.log "start read card"
        pasori.setTimeout 100
        pasori.polling 0xFE00, 0, (felica)=>
            unless felica
                # console.log "felica is not found"
                @readCard()
                return
            idm = felica.getIDm()
            setTimeout @readCard, 1500
            if idm is idmCache
                # console.log "Same card"
                return
            console.log idm
            idmCache = idm
            setTimeout deleteIdmCache, 3000
            @readData felica
            return

    deleteIdmCache = ->
        idmCache = ""

    readData: (felica)=>
        num = felica.readSingle 0x1A8B, 0, 0x0000
            .map (s)-> String.fromCharCode s
            .slice 2, 9
            .join ""
        console.log num

        name = felica.readSingle 0x1A8B, 0, 0x0001
            .filter (s)-> s isnt 0
            .map (s)-> String.fromCharCode s
            .join ""
        console.log name


card = new Card()

card.readCard()
