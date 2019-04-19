
import { DatabaseTable } from '../../schema';

export const userRoles = new DatabaseTable('user_roles', {
	id: 'id' as const,
	description: 'description' as const,
	createdTimestamp: 'created_timestamp' as const,
	updatedTimestamp: 'updated_timestamp' as const
});

/**
 * Contains all of the special user roles with elevated permissions that
 * can be assigned to a user
 */
export enum UserRoles {
	Admin = 'ADMIN',
	SuperModerator = 'SUPER_MODERATOR',
	Moderator = 'MODERATOR',
	Localization = 'LOCALIZATION'
}
