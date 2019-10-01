<?php
class ControllerModuleMostPopularByCat extends Controller {
	private $error = array(); 
	
	public function index() {   
		$this->language->load('module/most_popular_by_cat');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
				
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('most_popular_by_cat', $this->request->post);		
			
			$this->cache->delete('product');
			
			$this->session->data['success'] = $this->language->get('text_success');
						
			$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}
				
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_content_top'] = $this->language->get('text_content_top');
		$this->data['text_content_bottom'] = $this->language->get('text_content_bottom');		
		$this->data['text_column_left'] = $this->language->get('text_column_left');
		$this->data['text_column_right'] = $this->language->get('text_column_right');
		$this->data['text_select_all'] = $this->language->get('text_select_all');
		$this->data['text_unselect_all'] = $this->language->get('text_unselect_all');
		$this->data['text_expand'] = $this->language->get('text_expand');
		$this->data['text_collapse'] = $this->language->get('text_collapse');
		$this->data['text_powered'] = $this->language->get('text_powered');
		$this->data['text_vieved'] = $this->language->get('text_vieved');
		$this->data['text_purchased'] = $this->language->get('text_purchased');
		
		$this->data['entry_limit'] = $this->language->get('entry_limit');
		$this->data['entry_image'] = $this->language->get('entry_image');
		$this->data['entry_layout'] = $this->language->get('entry_layout');
		$this->data['entry_type'] = $this->language->get('entry_type');
		$this->data['entry_position'] = $this->language->get('entry_position');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
		$this->data['entry_category'] = $this->language->get('entry_category');
		
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_add_module'] = $this->language->get('button_add_module');
		$this->data['button_remove'] = $this->language->get('button_remove');
		
 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		
		if (isset($this->error['image'])) {
			$this->data['error_image'] = $this->error['image'];
		} else {
			$this->data['error_image'] = array();
		}
		
  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('module/most_popular_by_cat', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		$this->data['action'] = $this->url->link('module/most_popular_by_cat', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['modules'] = array();
		$category_list = array();

		if (isset($this->request->post['most_popular_by_cat_module'])) {
			$this->data['modules'] = $this->request->post['most_popular_by_cat_module'];
		} elseif ($this->config->get('most_popular_by_cat_module')) { 
			$this->data['modules'] = $this->config->get('most_popular_by_cat_module');
		}
		
		if (isset($this->request->post['most_popular_by_cat_category_module'])) {
			$category_list = $this->request->post['most_popular_by_cat_category_module'];
		} elseif ($this->config->get('most_popular_by_cat_category_module')) { 
			$category_list = $this->config->get('most_popular_by_cat_category_module');
		}
		
		$this->data['category_list'] = $category_list;
		
		$this->load->model('catalog/category');
		
		$this->data['categories'] = array();	
		
		$results = $this->model_catalog_category->getCategories(0);
		
			foreach ($results as $result){
			$single_category = false;
				foreach ($category_list as $array) {

				if ($array['category_list'] == $result['category_id']) {
				
				$single_category = true;
				}
				}
			$this->data['categories'][] = array(
			'category_id' => $result['category_id'],
			'name' => $result['name'],
			'single_category' => $single_category,
			
			);
			}

		
		
		$this->load->model('design/layout');
		
		$this->data['layouts'] = $this->model_design_layout->getLayouts();
		$this->data['type_vieved'] = 'type_vieved';
		$this->data['type_purchased'] = 'type_purchased';

		$this->template = 'module/most_popular_by_cat.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}
	
	protected function validate() {
		if (!$this->user->hasPermission('modify', 'module/most_popular_by_cat')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (isset($this->request->post['most_popular_by_cat_module'])) {
			foreach ($this->request->post['most_popular_by_cat_module'] as $key => $value) {
				if (!$value['image_width'] || !$value['image_height']) {
					$this->error['image'][$key] = $this->language->get('error_image');
				}
			}
		}		
				
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
}
?>