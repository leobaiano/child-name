import { FastifyRequest, FastifyReply } from 'fastify';
import { NameGeneratorService } from '../services/nameGeneratorService';
import { Options } from '../models/optionsModel';


export class NameGeneratorController {
    private nameGeneratorService: NameGeneratorService;

    constructor() {
        this.nameGeneratorService = new NameGeneratorService();
    }

    async getNames(options: Options, request: FastifyRequest, reply: FastifyReply) {
        try {
            const names = await this.nameGeneratorService.generateNames(options);
            reply.send(names);
        } catch (error) {
            reply.status(500).send({ error: 'Internal Server Error' });
        }
    }
}