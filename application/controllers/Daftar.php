<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Daftar extends CI_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->helper(array('form', 'url', 'string'));
        $this->load->library(array('session', 'form_validation', 'email'));
        $this->load->database();
        $this->load->model('MUser');
        if ($this->session->userdata('id') == true) {
            redirect(base_url());
        }
    }

    public function index()
    {
        $top['title'] = "Daftar - Komunitas";
        $this->load->view('layouts/Top', $top);
        $this->load->view('VDaftar');
        $this->load->view('layouts/Bottom');
    }

    public function auth()
    {
        if (isset($_POST['submit'])) {
            $this->form_validation->set_rules('email', 'Email', 'required|valid_email|is_unique[user.email]');
            $this->form_validation->set_message('is_unique', 'Error : email kamu sudah digunakan. Masuk atau gunakan email lain');
            if ($this->form_validation->run() == TRUE) {
                $attr = array(
                    'email' => $this->input->post('email'),
                    // 'password' => hash('md5', $this->input->post('password')),
                    'password' => password_hash($this->input->post('password'), PASSWORD_DEFAULT),
                    // 'nama' => $this->input->post('nama'),
                    'name' => $this->input->post('name'),
                    // 'phone' => $this->input->post('phone'),
                    'phone_number' => $this->input->post('phone_number'),
                    'image' => 'default.svg',
                    'role_id' => 1,
                    'is_active' => 1,
                    'date_created' => time(),
                    'token' => random_string('numeric', 5)
                );
                if ($this->MUser->add($attr)) {
                    
                    $this->setFlash('success', 'Success', 'Akun anda berhasil dibuat. Silahkan masuk');
                    redirect('masuk');
                } else {
                    $this->setFlash('warning', 'Error', 'Oops, terjadi error yang tidak diketahui');
                    redirect($_SERVER['HTTP_REFERER']);
                }
            } else {
                $this->setFlash('warning', 'Error', 'Oops, email sudah digunakan');
                redirect($_SERVER['HTTP_REFERER']);
            }
        } else {
            redirect('daftar');
        }
    }

    private function setFlash($type, $title, $message)
    {
        $this->session->set_flashdata([
            'type' => $type,
            'title' => $title,
            'msg' => $message
        ]);
    }
}
