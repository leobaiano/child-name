import fastify, { FastifyInstance } from 'fastify';
import { nameGenerator } from './modules/nameGenerator/routes/nameGeneratorRoutes';

const app: FastifyInstance = fastify();

nameGenerator(app);

const start = async () => {
    try {
      await app.ready();
      await app.listen({ port: 3000 });
      console.log('Servidor rodando na porta 3000');
    } catch (err) {
      console.error(err);
      process.exit(1);
    }
  };
  
  start();