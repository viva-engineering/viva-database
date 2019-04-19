
import { DatabaseTable } from '../../schema';

export const i18nTranslations = new DatabaseTable('i18n_translations', {
	languageCode: 'language_code' as const,
	componentCode: 'component_code' as const,
	labelCode: 'label_code' as const,
	labelText: 'label_text' as const,
	createdTimestamp: 'created_timestamp' as const,
	updatedTimestamp: 'updated_timestamp' as const
});
