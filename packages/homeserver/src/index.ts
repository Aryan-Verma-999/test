import { appPromise } from './homeserver.module';

const port = Number(process.env.SERVER_PORT) || 8080;

appPromise.then((app) => {
	app.listen(port);
	console.log(`🚀 Homeserver running at http://localhost:${port}`);
}).catch((err) => {
	console.error('Failed to start homeserver:', err);
	process.exit(1);
});

