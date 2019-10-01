<?php

class ControllerModuleMostPopularByCat extends Controller
{
    protected function index($setting)
    {
        $category_list = $this->config->get('most_popular_by_cat_category_module');

        if (isset($this->request->get['path'])) {

            $parts = explode('_', (string)$this->request->get['path']);

            $category_id = (int)array_pop($parts);

        } else {
            $category_id = 0;
        }
        $this->data['category_list'] = $category_list;

        foreach ($category_list as $array) {

            if ($array['category_list'] == $category_id) {

                $this->language->load('module/most_popular_by_cat');

                $this->data['heading_title'] = $this->language->get('heading_title');

                $this->data['button_cart'] = $this->language->get('button_cart');

                $this->load->model('catalog/product');

                $this->load->model('tool/image');

                $this->data['products'] = array();

                $data = array(
                    'sort' => 'p.viewed',
                    'order' => 'DESC',
                    'start' => 0,
                    'limit' => $setting['limit'],
                    'filter_category_id' => $category_id
                    );
                $type = $setting['type'];
                if ($type == 'type_vieved') {
                    $results = $this->model_catalog_product->getProducts($data);
                } else {
                    $results = $this->model_catalog_product->getPurchased($data);
                }

                foreach ($results as $result) {
                    if ($result['image']) {
                        $image = $this->model_tool_image->resize($result['image'], $setting['image_width'], $setting['image_height']);
                    } else {
                        $image = false;
                    }

                    if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                        $price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
                    } else {
                        $price = false;
                    }

                    if ((float)$result['special']) {
                        $special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
                    } else {
                        $special = false;
                    }

                    if ($this->config->get('config_review_status')) {
                        $rating = $result['rating'];
                    } else {
                        $rating = false;
                    }

                    $this->data['products'][] = array(
                        'product_id' => $result['product_id'],
                        'thumb' => $image,
                        'name' => $result['name'],
                        'price' => $price,
                        'special' => $special,
                        'rating' => $rating,
                        'reviews' => sprintf($this->language->get('text_reviews'), (int)$result['reviews']),
                        'href' => $this->url->link('product/product', 'product_id=' . $result['product_id'])
                        );
                }

                if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/most_popular_by_cat.tpl')) {
                    $this->template = $this->config->get('config_template') . '/template/module/most_popular_by_cat.tpl';
                } else {
                    $this->template = 'default/template/module/most_popular_by_cat.tpl';
                }


                $this->render();
            }
        }
    }
}

?>