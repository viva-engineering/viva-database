
export const usersTable = Object.freeze({
	name: 'users',
	columns: {
		id: 'id',
		email: 'email',
		name: 'name',
		phone: 'phone',
		location: 'location',
		birthday: 'birthday',
		friendCode: 'friend_code',
		discoverableByEmail: 'discoverable_by_email',
		discoverableByName: 'discoverable_by_name',
		discoverableByFriendCode: 'discoverable_by_friend_code',
		active: 'active',
		emailValidated: 'email_validated',
		containsExplicitContent: 'contains_explicit_content',
		explicitContentVisible: 'explicit_content_visible',
		isAdmin: 'is_admin',
		isModerator: 'is_moderator',
		createdTimestamp: 'created_timestamp',
		updatedTimestamp: 'updated_timestamp'
	}
});
