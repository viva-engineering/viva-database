
import { DatabaseTable } from '../../schema';

export const userApplications = new DatabaseTable('user_applications', {
	id: 'id' as const,
	userId: 'user_id' as const,
	applicationId: 'application_id' as const,
	userKeyDigest: 'user_key_digest' as const,
	active: 'active' as const,
	createdTimestamp: 'created_timestamp' as const,
	updatedTimestamp: 'updated_timestamp' as const
});
