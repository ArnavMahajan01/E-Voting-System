const express = require("express");
var router = express.Router();

router.use("/" , require("./home"));
router.use("/" , require("./account"));

module.exports = router;