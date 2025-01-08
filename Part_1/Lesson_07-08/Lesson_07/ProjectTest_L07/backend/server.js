const express = require("express");
const mongoose = require("mongoose");

const app = express();
const port = 3000;

const TestSchema = new mongoose.Schema({ name: String });
const TestModel = mongoose.model("Test", TestSchema);

app.get("/add", async (req, res) => {
    const newDoc = new TestModel({ name: "Docker Test" });
    await newDoc.save();
    res.send("Documento salvo no MongoDB!");
});

app.get("/list", async (req, res) => {
    const docs = await TestModel.find();
    res.json(docs);
});

mongoose.connect("mongodb://mongo:27017/mydb", { useNewUrlParser: true, useUnifiedTopology: true })
    .then(() => console.log("Connected to MongoDB"))
    .catch(err => console.log(err));

app.listen(port, () => {
    console.log(`Server running on http://localhost:${port}`);
});