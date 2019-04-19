
import { DatabaseTable } from '../../schema';

export const userGroupUsers = new DatabaseTable('user_group_users', {
	userGroupId: 'user_group_id' as const,
	userId: 'user_id' as const,
	createdTimestamp: 'created_timestamp' as const,
	updatedTimestamp: 'updated_timestamp' as const
});
