
import { DatabaseTable } from '../../schema';

export const sessions = new DatabaseTable('sessions', {
	id: 'id' as const,
	userId: 'user_id' as const,
	expiration: 'expiration' as const,
	applicationId: 'application_id' as const,
	createdTimestamp: 'created_timestamp' as const,
	updatedTimestamp: 'updated_timestamp' as const
});
