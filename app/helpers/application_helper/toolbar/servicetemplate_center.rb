class ApplicationHelper::Toolbar::ServicetemplateCenter < ApplicationHelper::Toolbar::Basic
  button_group('catalogitem_vmdb', [
    select(
      :catalogitem_vmdb_choice,
      'fa fa-cog fa-lg',
      t = N_('Configuration'),
      t,
      :items  => [
        button(
          :ab_group_new,
          'pficon pficon-add-circle-o fa-lg',
          t = N_('Add a new Button Group'),
          t,
          :klass => ApplicationHelper::Button::CatalogItemButtonNew,
        ),
        button(
          :ab_button_new,
          'pficon pficon-add-circle-o fa-lg',
          t = N_('Add a new Button'),
          t,
          :klass => ApplicationHelper::Button::CatalogItemButtonNew,
        ),
        button(
          :catalogitem_edit,
          'pficon pficon-edit fa-lg',
          t = N_('Edit this Item'),
          t,
          :url_parms => "main_div",
          :send_checked => true),
        button(
          :catalogitem_delete,
          'pficon pficon-delete fa-lg',
          N_('Remove this Catalog Item'),
          N_('Remove Catalog Item'),
          :url_parms => "main_div",
          :send_checked => true,
          :confirm   => N_("Warning: This Catalog Items and ALL of their components will be permanently removed!")),
      ]
    ),
  ])
  button_group('catalogitem_policy', [
    select(
      :catalogitem_policy_choice,
      'fa fa-shield fa-lg',
      t = N_('Policy'),
      t,
      :items => [
        button(
          :catalogitem_tag,
          'pficon pficon-edit fa-lg',
          N_('Edit Tags for this Catalog Item'),
          N_('Edit Tags'),
          :url_parms => "main_div",
          :send_checked => true),
      ]
    ),
  ])
end
