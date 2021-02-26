const winston = require("winston");

module.exports.logger = winston.createLogger
({
    transports : [
        new winston.transports.File
        ({
            level : 'debug',
            filename : 'timsheet-debug-log',
            json : true,
            format : winston.format.combine(winston.format.timestamp(), winston.format.json())
        }),
        new winston.transports.File
        ({
            level : 'error',
            filename : 'timsheet-err-log',
            json : true,
            format : winston.format.combine(winston.format.timestamp(), winston.format.json())
        }),
    ]
    
})