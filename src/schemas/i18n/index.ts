
import { DatabaseSchema } from '../schema';

import { i18nComponents } from './tables/i18n-components';
import { i18nLabels } from './tables/i18n-labels';
import { i18nLanguages } from './tables/i18n-languages';
import { i18nTranslations } from './tables/i18n-translations';

export const i18nSchema = new DatabaseSchema('viva_i18n', {
	i18nComponents,
	i18nLabels,
	i18nLanguages,
	i18nTranslations
});
