import { OpenAI } from "langchain/llms/openai";
import { PromptTemplate } from "langchain/prompts";
import { LLMChain } from "langchain/chains";
import { Options } from '../models/optionsModel';
import { Names } from '../models/namesModel';
import 'dotenv/config'

export class NameGenerator {

    async getNames(options: Options): Promise<Names> {
        const model = new OpenAI({ temperature: 0.9 });
        const template = "I need help choosing a name for a child that was just born in {country}, he is {gender}, parents like {musicStyle} songs and {movieCategory} movies. Taking into account the gender of the child, the country of birth and the tastes of the parents, suggest 10 names that parents are likely to like?";
        const prompt = new PromptTemplate({
            template: template,
            inputVariables: ["country", "gender", "musicStyle", "movieCategory"],
        });

        const chain = new LLMChain({ llm: model, prompt: prompt });
        const res = await chain.call(options);

        const names = {
            names: res.text,
        }
        return names;
    }
}