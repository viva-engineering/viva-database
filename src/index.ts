
import { DatabasePool } from '@viva-eng/database';
import { credentialsTable } from './tables/credentials';
import { friendsTable } from './tables/friends';
import { sessionsTable } from './tables/sessions';
import { usersTable } from './tables/users';

export { SelectQuery, WriteQuery } from './queries';

export const tables = {
	credentials: credentialsTable,
	friends: friendsTable,
	sessions: sessionsTable,
	users: usersTable
};

export let db: DatabasePool;

export const init = (params) => {
	db = new DatabasePool(params);
};
