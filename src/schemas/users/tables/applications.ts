
import { DatabaseTable } from '../../schema';

export const applications = new DatabaseTable('applications', {
	id: 'id' as const,
	name: 'name' as const,
	secretKeyDigest: 'secret_key_digest' as const,
	ownerUserId: 'owner_user_id' as const,
	active: 'active' as const,
	approved: 'approved' as const,
	createdTimestamp: 'created_timestamp' as const,
	updatedTimestamp: 'updated_timestamp' as const
});
