
import { DatabaseTable } from '../../schema';

export const friends = new DatabaseTable('friends', {
	userA: 'user_id_a' as const,
	userB: 'user_id_b' as const,
	createdTimestamp: 'created_timestamp' as const,
	updatedTimestamp: 'updated_timestamp' as const
});
