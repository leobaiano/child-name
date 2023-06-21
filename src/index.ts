import { OpenAI } from "langchain/llms/openai";
import { PromptTemplate } from "langchain/prompts";
import { LLMChain } from "langchain/chains";
import 'dotenv/config'

const musicStyle = "rock";
const movieCategory = "comedy";

interface Options {
    country: string,
    gender: string,
    musicStyle: string,
    movieCategory: string
}

const options: Options = {
    country: "Brazil",
    gender: "male",
    musicStyle: "rock",
    movieCategory: "comedy",
}


const model = new OpenAI({ temperature: 0.9 });
const template = "I need help choosing a name for a child that was just born in {country}, he is {gender}, parents like {musicStyle} songs and {movieCategory} movies. Taking into account the gender of the child, the country of birth and the tastes of the parents, suggest 10 names that parents are likely to like?";
const prompt = new PromptTemplate({
    template: template,
    inputVariables: ["country", "gender", "musicStyle", "movieCategory"],
});

const chain = new LLMChain({ llm: model, prompt: prompt });

(async function getNames(options: Options) {
    const res = await chain.call(options);

    const response = res.text;

    console.log(response);
})(options);