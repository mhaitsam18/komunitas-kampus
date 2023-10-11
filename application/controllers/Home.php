<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Home extends CI_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->database();
        $this->load->model('MKomunitas');
        $this->load->model('MAnggota');
        if ($this->session->userdata('id') == FALSE) {
            redirect(base_url() . 'masuk');
        }
    }

    public function index()
    {
        $data['komunitas'] = $this->MAnggota->me($this->session->userdata('id'));
        $top['title'] = "Home - Komunitas";
        $this->load->view('layouts/Top', $top);
        $this->load->view('layouts/Nav');
        $this->load->view('VHome', $data);
        $this->load->view('layouts/Bottom');
    }
}
