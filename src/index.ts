import { OpenAI } from "langchain/llms/openai";
import 'dotenv/config'

const model = new OpenAI({
    openAIApiKey: process.env.OPENAI_API_KEY,
    temperature: 0.9,
});

(async function main () {
console.log("init");
const res = await model.call(
    "What would be a good company name a company that makes colorful socks?",
);
console.log(res);
})();