
import { DatabasePool } from '@viva-eng/database';

export { SelectQuery, WriteQuery } from './queries';
export { credentialsTable } from './tables/credentials';
export { friendsTable } from './tables/friends';
export { sessionsTable } from './tables/sessions';
export { usersTable } from './tables/users';

export let db: DatabasePool;

export const init = (params) => {
	db = new DatabasePool(params);
};
