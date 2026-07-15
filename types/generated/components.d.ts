import type { Schema, Struct } from '@strapi/strapi';

export interface SectionAboutMeSectionAboutMe extends Struct.ComponentSchema {
  collectionName: 'components_section_about_me_section_about_mes';
  info: {
    displayName: 'section about me';
    icon: 'alien';
  };
  attributes: {};
}

declare module '@strapi/strapi' {
  export namespace Public {
    export interface ComponentSchemas {
      'section-about-me.section-about-me': SectionAboutMeSectionAboutMe;
    }
  }
}
