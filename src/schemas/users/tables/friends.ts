
import { Bit, TimestampString } from '../../../types';
import { DatabaseTable, ColumnList } from '../../schema';

export interface FriendsColumns {
	requesting_user_id_a: number;
	requested_user_id_b: number;
	accepted: Bit;
	created_timestamp: TimestampString;
	updated_timestamp: TimestampString;
}

export const friends = new DatabaseTable('friends', {
	requestingUserId: 'requesting_user_id' as const,
	requestedUserId: 'requested_user_id' as const,
	accepted: 'accepted' as const,
	createdTimestamp: 'created_timestamp' as const,
	updatedTimestamp: 'updated_timestamp' as const
});
