
import { DatabaseTable } from '../../schema';

export const userGroups = new DatabaseTable('user_groups', {
	id: 'id' as const,
	userId: 'user_id' as const,
	name: 'name' as const,
	createdTimestamp: 'created_timestamp' as const,
	updatedTimestamp: 'updated_timestamp' as const
});
