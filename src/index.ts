
import { DatabasePool } from '@viva-eng/database';
import { credentialsTable } from './tables/credentials';
import { friendsTable } from './tables/friends';
import { sessionsTable } from './tables/sessions';
import { usersTable } from './tables/users';
import { privacySettingsTable } from './tables/privacy-settings';

export { SelectQuery, WriteQuery } from './queries';

export { Bit, PrivacyFlag } from './types';

export const tables = {
	credentials: credentialsTable,
	friends: friendsTable,
	sessions: sessionsTable,
	users: usersTable,
	privacySettings: privacySettingsTable
};

export let db: DatabasePool;

export const init = (params) => {
	db = new DatabasePool(params);
};
