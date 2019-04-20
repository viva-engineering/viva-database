
import { Bit, TimestampString } from '../../../types';
import { DatabaseTable, ColumnList } from '../../schema';

export interface ApplicationsColumns {
	id: number;
	name: string;
	secret_key_digest: string;
	owner_user_id: number;
	active: Bit;
	approved: Bit;
	created_timestamp: TimestampString;
	updated_timestamp: TimestampString;
}

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
