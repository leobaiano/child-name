import { FastifyInstance, FastifyRequest, FastifyReply } from 'fastify';
import { NameGeneratorController } from '../controllers/nameGeneratorController';
import { Options } from '../models/optionsModel';

export function nameGenerator(app: FastifyInstance) {
    const nameGeneratorController = new NameGeneratorController();

    app.get('/names', async (request: FastifyRequest, reply: FastifyReply) => {
        try {
            const options: Options = request.query as Options;

            const names = await nameGeneratorController.getNames(options, request, reply);
            reply.send(names);
        } catch (error) {
            reply.status(500).send({ error: 'Route: Internal Server Error' });
        }
    });
}