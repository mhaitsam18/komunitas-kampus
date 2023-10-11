<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Arsip extends CI_Controller
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
        if ($this->session->userdata('id') == FALSE) {
            redirect(base_url() . 'masuk');
        }
    }

    public function index()
    {
        $data['komunitas'] = $this->MAnggota->me($this->session->userdata('id'));
        $top['title'] = "Arsip - Komunitas";
        $this->load->view('layouts/Top', $top);
        $this->load->view('layouts/Nav');
        $this->load->view('arsip/VArsip', $data);
        $this->load->view('layouts/Bottom');
    }

    public function detail($token, $id_anggota = null)
    {
        $data = [
            'komunitas' => $this->MKomunitas->cekWithToken($token)->row_array(),
            'arsip' => $this->MArsip->getByTokenKomunitas($token)
        ];
        $top['title'] = "Detail Arsip - Komunitas";

        $data['cek_anggota'] = $this->db->get_where('anggota', ['id' => $id_anggota])->row();
        $this->load->view('layouts/Top', $top);
        $this->load->view('layouts/Nav');
        $this->load->view('arsip/VDetailArsip', $data);
        $this->load->view('layouts/Bottom');
    }

    public function store()
    {
        if (isset($_POST['submit'])) {
            $cekKomunitas = $this->MKomunitas->cekWithId($this->input->post('id_komunitas'));
            $cekAdmin = $cekAdmin = $this->MAnggota->cekAdmin($this->session->userdata('id'), $cekKomunitas[0]->token);
            if ($cekAdmin) {
                $config['upload_path']  = 'assets/arsip';
                $config['allowed_types']  = 'jpg|png|doc|docx|xls|xlsx|txt|pdf|ppt|pptx';
                $config['encrypt_name'] = TRUE;
                $config['max_size']      = 1000024;
                $this->load->library('upload', $config);
                if ($this->upload->do_upload('file')) {
                    $file = $this->upload->data();
                    $attr = array(
                        'id_user' => $this->session->userdata('id'),
                        'nama_user' => $this->session->userdata('name'),
                        'nama_komunitas' => $cekKomunitas[0]->nama,
                        'id_komunitas' => $cekKomunitas[0]->id,
                        'token_komunitas' => $cekKomunitas[0]->token,
                        'nama' => $this->input->post('nama'),
                        'file' => $file['file_name'],
                        'tipe' => $this->input->post('tipe'),
                    );
                    if ($this->MArsip->add($attr)) {
                        $this->setFlash('success', 'Sukses', 'Berhasil menambahkan arsip hasil rapat');
                        redirect($_SERVER['HTTP_REFERER']);
                    } else {
                        $this->setFlash('warning', 'Error', 'Oops, some error occured');
                        redirect($_SERVER['HTTP_REFERER']);
                    }
                } else {
                    $this->setFlash('warning', 'Error', 'Oops, some error occured');
                    redirect($_SERVER['HTTP_REFERER']);
                }
            } else {
                $this->setFlash('warning', 'Error', 'Oops, hanya admin yang dapat menambahkan arsip hasil rapat');
                redirect($_SERVER['HTTP_REFERER']);
            }
        } else {
            redirect('arsip');
        }
    }

    public function delete($id_komunitas, $id_arsip)
    {
        $cekKomunitas = $this->MKomunitas->cekWithId($id_komunitas);
        $cekAdmin = $cekAdmin = $this->MAnggota->cekAdmin($this->session->userdata('id'), $cekKomunitas[0]->token);
        if ($cekAdmin) {
            $hapus = $this->MArsip->delete($id_arsip);
            if ($hapus) {
                $this->setFlash('success', 'Sukses', 'Berhasil menghapus arsip hasil rapat');
                redirect($_SERVER['HTTP_REFERER']);
            } else {
                $this->setFlash('warning', 'Error', 'Oops, some error occured');
                redirect($_SERVER['HTTP_REFERER']);
            }
        } else {
            $this->setFlash('warning', 'Error', 'Oops, hanya admin yang dapat meghapus arsip');
            redirect($_SERVER['HTTP_REFERER']);
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
