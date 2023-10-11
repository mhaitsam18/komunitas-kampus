<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Profile extends CI_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->database();
        $this->load->helper('string');
        $this->load->model('MKomunitas');
        $this->load->model('MAnggota');
        $this->load->model('MJadwal');
        $this->load->model('MArsip');
        $this->load->model('MAbsensi');
        $this->load->model('MUser');
        if ($this->session->userdata('id') == FALSE) {
            redirect(base_url() . 'masuk');
        }
    }

    public function index()
    {
        $top['title'] = "Profile - Komunitas";
        $this->load->view('layouts/Top', $top);
        $this->load->view('layouts/Nav');
        $this->load->view('VProfile');
        $this->load->view('layouts/Bottom');
    }

    public function update()
    {
        if (isset($_POST['submit'])) {
            $data = [
                'place_of_birth' => $this->input->post('place_of_birth'),
                'birthday' => $this->input->post('birthday'),
                'phone_number' => $this->input->post('phone_number'),
                'address' => $this->input->post('address')
            ];
            if ($this->MUser->update($data, $this->session->userdata('id'))) {
                $this->session->set_userdata([
                    'place_of_birth' => $this->input->post('place_of_birth'),
                    'birthday' => $this->input->post('birthday'),
                    'phone_number' => $this->input->post('phone_number'),
                    'address' => $this->input->post('address')
                ]);
                $this->setFlash('success', 'Sukses', 'Data berhasil diperbaharui');
                redirect($_SERVER['HTTP_REFERER']);
            } else {
                $this->setFlash('warning', 'Error', 'Oops, gagal mengubah data');
                redirect($_SERVER['HTTP_REFERER']);
            }
        } else {
            redirect('organizer');
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
