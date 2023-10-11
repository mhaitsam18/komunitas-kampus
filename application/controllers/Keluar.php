<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Keluar extends CI_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->helper(array('form', 'url'));
        $this->load->library(array('session'));
    }

    public function index()
    {
        $this->session->sess_destroy();
        redirect('masuk');
    }
}
