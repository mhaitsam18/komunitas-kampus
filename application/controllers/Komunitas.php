<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Komunitas extends CI_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->database();
        $this->load->helper('string');
        $this->load->model('MKomunitas');
        $this->load->model('MAnggota');
        $this->load->model('MUser');
        if ($this->session->userdata('id') == FALSE) {
            redirect(base_url() . 'masuk');
        }
    }

    public function index()
    {
        return redirect();
    }

    public function buat()
    {
        $top['title'] = "Add - Komunitas";
        $this->load->view('layouts/Top', $top);
        $this->load->view('layouts/Nav');
        $this->load->view('komunitas/Buat');
        $this->load->view('layouts/Bottom');
    }

    public function create()
    {
        if (isset($_POST['submit'])) {
            $config['upload_path']  = 'assets/images/komunitas';
            $config['allowed_types']  = 'jpg|png';
            $config['encrypt_name'] = TRUE;
            $config['max_size']      = 1024;

            $this->load->library('upload', $config);

            if ($this->upload->do_upload('logo')) {
                $gbr = $this->upload->data();
                $config['image_library'] = 'gd2';
                $config['source_image'] = './assets/img/logo/' . $gbr['file_name'];
                $config['create_thumb'] = TRUE;
                $config['maintain_ratio'] = TRUE;
                $config['width']         = 300;
                $config['height']       = 300;

                $this->load->library('image_lib', $config);
                $this->image_lib->resize();
                $gambar = $gbr['file_name'];

                $token = random_string('numeric', 5);

                $attr = array(
                    'token' => $token,
                    'nama' => $this->input->post('nama'),
                    'detail' => $this->input->post('detail'),
                    'id_creator' => $this->session->userdata('id'),
                    'logo' => $gambar
                );

                if ($this->MKomunitas->add($attr)) {
                    $cek = $this->MKomunitas->cekWithToken($token)->row_array();
                    $attr2 = array(
                        'id_komunitas' => $cek['id'],
                        'token_komunitas' => $token,
                        'id_user' => $this->session->userdata('id'),
                        'nama_user' => $this->session->userdata('name'),
                        'jabatan' => $this->input->post('jabatan'),
                        'is_admin' => 1
                    );

                    $this->MAnggota->addAnggota($attr2);

                    $this->setFlash('success', 'Success', 'Yeay, komunitas berhasil dibuat');
                    redirect('komunitas/detail/' . $token);
                } else {
                    $this->setFlash('danger', 'Error', 'Oops, terjadi kegagalan saat membuat keanggotaan');
                    redirect($_SERVER['HTTP_REFERER']);
                }
            } else {
                $this->setFlash('warning', 'Error', 'Ooops, terjadi kegagalan');
                redirect($_SERVER['HTTP_REFERER']);
            }
        } else {
            redirect('komunitas/add');
        }
    }

    public function detail($token, $id_anggota = null)
    {
        $cek = $this->MKomunitas->cekWithToken($token)->row_array();
        $komunitas['data'] = $cek;

        $cekAnggota = $this->MAnggota->getAnggota($token);
        $komunitas['anggota'] = $cekAnggota;

        $komunitas['cek_anggota'] = $this->db->get_where('anggota', ['id' => $id_anggota])->row();
        $top['title'] = $cek['nama'];
        $this->load->view('layouts/Top', $top);
        $this->load->view('layouts/Nav');
        $this->load->view('komunitas/Detail', $komunitas);
        $this->load->view('layouts/Bottom');
    }

    public function delete($id_komunitas, $token_komunitas)
    {
        $cekAdmin = $this->MAnggota->cekAdmin($this->session->userdata('id'), $token_komunitas);
        if ($cekAdmin) {
            $hapus = $this->MKomunitas->delete($id_komunitas);
            $this->db->delete('anggota', ['id_komunitas' => $id_komunitas]);
            if ($hapus) {
                $this->setFlash('success', 'Sukses', 'Berhasil menghapus komunitas');
                redirect($_SERVER['HTTP_REFERER']);
            } else {
                $this->setFlash('warning', 'Error', 'Oops, some error occured');
                redirect($_SERVER['HTTP_REFERER']);
            }
        } else {
            $this->setFlash('warning', 'Error', 'Oops, hanya admin yang dapat meghapus komunitas');
            redirect($_SERVER['HTTP_REFERER']);
        }
    }

    public function addanggota()
    {
        if (isset($_POST['submit'])) {
            $email = $this->input->post('email');
            $jabatan = $this->input->post('jabatan');
            $admin = $this->input->post('is_admin');
            $id_komunitas = $this->input->post('id_komunitas');
            $token_komunitas = $this->input->post('token_komunitas');

            $cek = $this->MUser->cekWithEmail($email);
            if ($cek->num_rows() > 0) {
                $data = $cek->row_array();
                $id_user = $data['id'];
                $cek2 = $this->MAnggota->getAnggotaById($id_komunitas, $id_user);
                if ($cek2->num_rows() == 0) {
                    $attr = array(
                        'id_komunitas' => $id_komunitas,
                        'id_user' => $id_user,
                        'nama_user' => $data['name'],
                        'is_admin' => $admin,
                        'token_komunitas' => $token_komunitas,
                        'jabatan' => $jabatan
                    );

                    $add = $this->MAnggota->addAnggota($attr);

                    if ($add) {
                        $this->setFlash('success', 'Sukses', 'Berhasil menambahkan anggota');
                    } else {
                        $this->setFlash('warning', 'Error', 'Ooops, something error');
                    }
                    redirect($_SERVER['HTTP_REFERER']);
                } else {
                    $this->setFlash('warning', 'Error', 'User sudah menjadi anggota');
                    redirect($_SERVER['HTTP_REFERER']);
                }
            } else {
                $this->setFlash('warning', 'Error', 'Ooops, user tidak ditemukan');
                redirect($_SERVER['HTTP_REFERER']);
            }
        } else {
            redirect(base_url());
        }
    }

    public function setadmin($id_user, $token_komunitas)
    {
        $cekAdmin = $this->MAnggota->cekAdmin($this->session->userdata('id'), $token_komunitas);
        if ($cekAdmin) {
            $data = [
                'is_admin' => '1'
            ];
            $this->MAnggota->setAnggota($data, $id_user);
            redirect($_SERVER['HTTP_REFERER']);
        } else {
            $this->setFlash('warning', 'Error', 'Oops, hanya admin yang dapat meghapus anggota');
            redirect($_SERVER['HTTP_REFERER']);
        }
    }

    public function setanggota($id_user, $token_komunitas, $uid)
    {
        $komunitas = $this->MKomunitas->cekWithToken($token_komunitas)->row_array();
        if ($uid == $komunitas['id_creator']) {
            $this->setFlash('warning', 'Error', 'Oops, kreator tidak bisa diubah');
            redirect($_SERVER['HTTP_REFERER']);
        } else {
            $cekAdmin = $this->MAnggota->cekAdmin($this->session->userdata('id'), $token_komunitas);
            if ($cekAdmin) {
                $data = [
                    'is_admin' => '0'
                ];
                $this->MAnggota->setAnggota($data, $id_user);
                redirect($_SERVER['HTTP_REFERER']);
            } else {
                $this->setFlash('warning', 'Error', 'Oops, hanya admin yang dapat meghapus anggota');
                redirect($_SERVER['HTTP_REFERER']);
            }
        }
    }

    public function deleteanggota($id_user, $token_komunitas)
    {
        $komunitas = $this->MKomunitas->cekWithToken($token_komunitas)->row_array();
        if ($id_user == $komunitas['id_creator']) {
            $this->setFlash('warning', 'Error', 'Oops, kreator tidak bisa dihapus');
            redirect($_SERVER['HTTP_REFERER']);
        } else {
            $cekAdmin = $this->MAnggota->cekAdmin($this->session->userdata('id'), $token_komunitas);
            if ($cekAdmin) {
                $hapus = $this->MAnggota->delete($id_user);
                if ($hapus) {
                    $this->setFlash('success', 'Sukses', 'Berhasil menghapus anggota dari komunitas');
                    redirect($_SERVER['HTTP_REFERER']);
                } else {
                    $this->setFlash('warning', 'Error', 'Oops, some error occured');
                    redirect($_SERVER['HTTP_REFERER']);
                }
            } else {
                $this->setFlash('warning', 'Error', 'Oops, hanya admin yang dapat meghapus anggota');
                redirect($_SERVER['HTTP_REFERER']);
            }
        }
    }

    public function detailanggota($id_user)
    {
        $data['profil'] = $this->MUser->anggota($id_user);
        $top['title'] = "Profil Anggota - Komunitas";
        $this->load->view('layouts/Top', $top);
        $this->load->view('layouts/Nav');
        $this->load->view('komunitas/ProfilAnggota', $data);
        $this->load->view('layouts/Bottom');
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
