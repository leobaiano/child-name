import { FastifyInstance, FastifyRequest, FastifyReply } from 'fastify';
import { NameGenerator } from '../controllers/nameGeneratorController';
import { Names } from '../models/namesModel';

export function exampleRoutes(app: FastifyInstance) {
    app.get('/names', async (request: FastifyRequest, reply: FastifyReply) => {
        try {
            const { country, geder, musicStyle, movieCategory } = request.params as Record<string, string>;

            const names: Names = { names: 'Names' };

            reply.send({  names });
        } catch (error) {
            reply.status(500).send({ error: 'Internal Server Error' });
        }
    });
}