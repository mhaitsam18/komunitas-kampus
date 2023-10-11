<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Masuk extends CI_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->helper(array('form', 'url'));
        $this->load->library(array('session', 'form_validation', 'email'));
        $this->load->database();
        $this->load->model('MUser');
        if ($this->session->userdata('id') == true) {
            redirect(base_url());
        }
    }

    public function index()
    {
        $top['title'] = "Masuk - Komunitas";
        $this->load->view('layouts/Top', $top);
        $this->load->view('VMasuk');
        $this->load->view('layouts/Bottom');
    }

    public function auth($email = null)
    {
        if ($email) {
            $user = $this->db->get_where('user', ['email' => $email])->row_array();
            $data = $cek->row_array();
            $this->session->set_userdata([
                'id' => $user['id'],
                'name' => $user['name'],
                'email' => $user['email'],
                'phone_number' => $user['phone_number'],
                'place_of_birth' => $user['place_of_birth'],
                'birthday' => $user['birthday'],
                'address' => $user['address']
            ]);
            redirect();
        }
        if (isset($_POST['submit'])) {
            $email = $this->input->post('email');
            $password = $this->input->post('password');
            // $password = hash('md5', $password);
            // $cek = $this->MUser->cekuser($email, $password);
            // if ($cek->num_rows() > 0) {
            $user = $this->db->get_where('user', ['email' => $email])->row_array();
            if (password_verify($password, $user['password'])) {
                // $data = $cek->row_array();
                $this->session->set_userdata([
                    'id' => $user['id'],
                    // 'nama' => $data['nama'],
                    'name' => $user['name'],
                    'email' => $user['email'],
                    // 'phone' => $data['phone'],
                    'phone_number' => $user['phone_number'],
                    // 'tempat_lahir' => $data['tempat_lahir'],
                    'place_of_birth' => $user['place_of_birth'],
                    // 'tgl_lahir' => $data['tgl_lahir'],
                    'birthday' => $user['birthday'],
                    // 'alamat' => $data['alamat']
                    'address' => $user['address'],
                    'role_id' => $user['role_id']
                ]);
                redirect('');
            } else {
                $this->setFlash('warning', 'Error', 'Oops, akun tidak ditemukan');
                redirect($_SERVER['HTTP_REFERER']);
            }
        } else {
            redirect('masuk');
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
