<?php echo $header; ?>
<div id="content">
    <div class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
        <?php } ?>
    </div>
    <?php if ($error_warning) { ?>
    <div class="warning"><?php echo $error_warning; ?></div>
    <?php } ?>
    <div class="box">
        <div class="heading">
            <h1><img src="view/image/module.png" alt=""/> <?php echo $heading_title; ?></h1>

            <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a></div>
        </div>
        <div class="content">
            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
                <div><b><?php echo $entry_category; ?></b></div>
                <div style="float: left; margin-right: 20px; margin-bottom: 20px;">
                    <div class="scrollbox" id="scrollbox">
                        <?php $class = 'odd'; ?>
                        <?php $i = 0; foreach ($categories as $category) { $i++; ?>
                        <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>

                        <div class="<?php echo $class; ?>">

                            <?php if ($category['single_category']) { ?>
                            <input type="checkbox" name="most_popular_by_cat_category_module[<?php echo $i; ?>][category_list]" value="<?php echo $category['category_id']; ?>" checked="checked"/>
                            <?php echo $category['name']; ?>
                            <?php } else { ?>
                            <input type="checkbox" name="most_popular_by_cat_category_module[<?php echo $i; ?>][category_list]" value="<?php echo $category['category_id']; ?>"/>
                            <?php echo $category['name']; ?>
                            <?php } ?>
                        </div>
                        <?php } ?>
                    </div>
                    <a onclick="$(this).parent().find(':checkbox').attr('checked', true);"><?php echo $text_select_all; ?></a> / <a
                            onclick="$(this).parent().find(':checkbox').attr('checked', false);"><?php echo $text_unselect_all; ?></a> <a class="expand" style="margin-left: 90px;"><?php echo $text_expand; ?></a>

                </div>
                <div style="float:left; margin-bottom: 20px; ">

                    <table id="module" class="list">
                        <thead>
                        <tr>
                            <td class="left"><?php echo $entry_limit; ?></td>
                            <td class="left"><?php echo $entry_image; ?></td>
                            <td class="left"><?php echo $entry_layout; ?></td>
                            <td class="left"><?php echo $entry_type; ?></td>
                            <td class="left"><?php echo $entry_position; ?></td>
                            <td class="left"><?php echo $entry_status; ?></td>
                            <td class="right"><?php echo $entry_sort_order; ?></td>
                            <td></td>

                        </tr>
                        </thead>
                        <?php $module_row = 0; ?>
                        <?php foreach ($modules as $module) { ?>

                        <tbody id="module-row<?php echo $module_row; ?>">
                        <tr>
                        <tr>
                            <td class="left"><input type="text" name="most_popular_by_cat_module[<?php echo $module_row; ?>][limit]" value="<?php echo $module['limit']; ?>" size="1"/></td>
                            <td class="left"><input type="text" name="most_popular_by_cat_module[<?php echo $module_row; ?>][image_width]" value="<?php echo $module['image_width']; ?>" size="3"/>
                                <input type="text" name="most_popular_by_cat_module[<?php echo $module_row; ?>][image_height]" value="<?php echo $module['image_height']; ?>" size="3"/>
                                <?php if (isset($error_image[$module_row])) { ?>
                                <span class="error"><?php echo $error_image[$module_row]; ?></span>
                                <?php } ?></td>
                            <td class="left"><select name="most_popular_by_cat_module[<?php echo $module_row; ?>][layout_id]">
                                    <?php foreach ($layouts as $layout) { ?>
                                    <?php if (($layout['layout_id'] == 3) || ($layout['layout_id'] == 2)) { ?>
                                    <?php if ($layout['layout_id'] == $module['layout_id']) { ?>
                                    <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                                    <?php } else { ?>
                                    <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                                    <?php } ?>
                                    <?php } ?>
                                    <?php } ?>
                                </select></td>
                            <td class="left"><select name="most_popular_by_cat_module[<?php echo $module_row; ?>][type]">
                                    <?php if ($type_vieved == $module['type']) { ?>
                                    <option value="<?php echo $type_vieved; ?>" selected="selected"><?php echo $text_vieved; ?></option>
                                    <?php } else { ?>
                                    <option value="<?php echo $type_vieved; ?>"><?php echo $text_vieved; ?></option>
                                    <?php } ?>
                                    <?php if ($type_purchased == $module['type']) { ?>
                                    <option value="<?php echo $type_purchased; ?>" selected="selected"><?php echo $text_purchased; ?></option>
                                    <?php } else { ?>
                                    <option value="<?php echo $type_purchased; ?>"><?php echo $text_purchased; ?></option>
                                    <?php } ?>
                                </select></td>
                            <td class="left"><select name="most_popular_by_cat_module[<?php echo $module_row; ?>][position]">
                                    <?php if ($module['position'] == 'content_top') { ?>
                                    <option value="content_top" selected="selected"><?php echo $text_content_top; ?></option>
                                    <?php } else { ?>
                                    <option value="content_top"><?php echo $text_content_top; ?></option>
                                    <?php } ?>
                                    <?php if ($module['position'] == 'content_bottom') { ?>
                                    <option value="content_bottom" selected="selected"><?php echo $text_content_bottom; ?></option>
                                    <?php } else { ?>
                                    <option value="content_bottom"><?php echo $text_content_bottom; ?></option>
                                    <?php } ?>
                                    <?php if ($module['position'] == 'column_left') { ?>
                                    <option value="column_left" selected="selected"><?php echo $text_column_left; ?></option>
                                    <?php } else { ?>
                                    <option value="column_left"><?php echo $text_column_left; ?></option>
                                    <?php } ?>
                                    <?php if ($module['position'] == 'column_right') { ?>
                                    <option value="column_right" selected="selected"><?php echo $text_column_right; ?></option>
                                    <?php } else { ?>
                                    <option value="column_right"><?php echo $text_column_right; ?></option>
                                    <?php } ?>
                                </select></td>
                            <td class="left"><select name="most_popular_by_cat_module[<?php echo $module_row; ?>][status]">
                                    <?php if ($module['status']) { ?>
                                    <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                    <option value="0"><?php echo $text_disabled; ?></option>
                                    <?php } else { ?>
                                    <option value="1"><?php echo $text_enabled; ?></option>
                                    <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                    <?php } ?>
                                </select></td>
                            <td class="right"><input type="text" name="most_popular_by_cat_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" size="3"/></td>
                            <td class="left"><a onclick="$('#module-row<?php echo $module_row; ?>').remove();" class="button"><?php echo $button_remove; ?></a></td>
                        </tr>
                        </tbody>
                        <?php $module_row++; ?>
                        <?php } ?>
                        <tfoot>
                        <tr>
                            <td colspan="7"></td>
                            <td class="left"><a onclick="addModule();" class="button"><?php echo $button_add_module; ?></a></td>

                        </tr>
                        </tfoot>
                    </table>
                </div>
            </form>
        </div>
    </div>
    <div style="text-align:center"><?php echo $text_powered; ?></div>
</div>
<script type="text/javascript"><!--
    var expand = '<?php echo $text_expand; ?>';
    var collapse = '<?php echo $text_collapse; ?>';
    $(function () {
        $('a.expand').live('click', function () {
            $('.scrollbox').css('height', 'auto');
            $(this).removeClass().html(collapse).addClass('collapse');

        })

        $('a.collapse').live('click', function () {
            $('.scrollbox').css('height', '100px');
            $(this).removeClass().html(expand).addClass('expand');
        })

    });
    //--></script>
<script type="text/javascript"><!--
    var module_row = <?php echo $module_row; ?> ;

    function addModule() {
        html = '<tbody id="module-row' + module_row + '">';
        html += '  <tr>';
        html += '    <td class="left"><input type="text" name="most_popular_by_cat_module[' + module_row + '][limit]" value="5" size="1" /></td>';
        html += '    <td class="left"><input type="text" name="most_popular_by_cat_module[' + module_row + '][image_width]" value="80" size="3" /> <input type="text" name="most_popular_by_cat_module[' + module_row + '][image_height]" value="80" size="3" /></td>';
        html += '    <td class="left"><select name="most_popular_by_cat_module[' + module_row + '][layout_id]">';
        <?php foreach($layouts as $layout) { ?>
            <?php if (($layout['layout_id'] == 3) || ($layout['layout_id'] == 2)) { ?>
                html += '      <option value="<?php echo $layout['layout_id']; ?>"><?php echo addslashes($layout['name']); ?></option>';
            <?php } ?>
        <?php } ?>
        html += '    </select></td>';
        html += '    <td class="left"><select name="most_popular_by_cat_module[' + module_row + '][type]">';
        html += '	   <option value="<?php echo $type_vieved; ?>"><?php echo $text_vieved; ?></option>';
        html += '	   <option value="<?php echo $type_purchased; ?>"><?php echo $text_purchased; ?></option>';
        html += '    </select></td>';
        html += '    <td class="left"><select name="most_popular_by_cat_module[' + module_row + '][position]">';
        html += '      <option value="content_top"><?php echo $text_content_top; ?></option>';
        html += '      <option value="content_bottom"><?php echo $text_content_bottom; ?></option>';
        html += '      <option value="column_left"><?php echo $text_column_left; ?></option>';
        html += '      <option value="column_right"><?php echo $text_column_right; ?></option>';
        html += '    </select></td>';
        html += '    <td class="left"><select name="most_popular_by_cat_module[' + module_row + '][status]">';
        html += '      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
        html += '      <option value="0"><?php echo $text_disabled; ?></option>';
        html += '    </select></td>';
        html += '    <td class="right"><input type="text" name="most_popular_by_cat_module[' + module_row + '][sort_order]" value="" size="3" /></td>';
        html += '    <td class="left"><a onclick="$(\'#module-row' + module_row + '\').remove();" class="button"><?php echo $button_remove; ?></a></td>';
        html += '  </tr>';
        html += '</tbody>';

        $('#module tfoot').before(html);

        module_row++;
    }
    //--></script>
<?php echo $footer; ?>