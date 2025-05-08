const express = require("express");
const router = express.Router();

// Rota básica para teste
router.get("/", (req, res) => {
  res.send("Olá, faça sua reserva! Seu carro vai estar seguro!");
});

// Exportando o router como um middleware Express
module.exports = router;
