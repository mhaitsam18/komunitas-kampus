<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Jadwal extends CI_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->database();
        $this->load->model('MKomunitas');
        $this->load->model('MAnggota');
        $this->load->model('MJadwal');
        if ($this->session->userdata('id') == FALSE) {
            redirect(base_url() . 'masuk');
        }
    }

    public function index()
    {
        // $anggota = $this->MAnggota->meWithoutJoin($this->session->userdata('id'));
        // $jadwal = [];
        // foreach ($anggota as $a) {
        //     $raw = $this->MJadwal->getWithKomunitas($a->id_komunitas);
        //     array_push($jadwal, $raw);
        // };

        // $this->db->select('*');
        // $this->db->from('anggota');
        // $this->db->where('id_user', $id_user);
        // $anggota = $this->db->get()->result();

        $this->db->select('*, jadwal_rapat.id AS id_jadwal_rapat');
        $this->db->where('anggota.id_user', $this->session->userdata('id'));
        $this->db->join('komunitas', 'komunitas.id = jadwal_rapat.id_komunitas');
        $this->db->join('anggota', 'anggota.id_komunitas = komunitas.id');
        $data['jadwal_rapat'] = $this->db->get('jadwal_rapat')->result();

        $data['cek_admin'] = $this->db->get_where('anggota', [
            'id_user' => $this->session->userdata('id'),
            'is_admin' => 1
        ])->row();

        $top['title'] = "Agenda - Komunitas";
        $this->load->view('layouts/Top', $top);
        $this->load->view('layouts/Nav');
        $this->load->view('jadwal/VJadwal', $data);
        $this->load->view('layouts/Bottom');
    }

    public function buat()
    {
        // $data['komunitas'] = $this->MAnggota->me($this->session->userdata('id'));
        $data['komunitas'] = $this->MAnggota->me_admin($this->session->userdata('id'));
        $top['title'] = "Buat Jadwal Rapat - Komunitas";
        $this->load->view('layouts/Top', $top);
        $this->load->view('layouts/Nav');
        $this->load->view('jadwal/VBuatJadwal', $data);
        $this->load->view('layouts/Bottom');
    }

    public function detail($id_jadwal)
    {
        $data['jadwal'] = $this->MJadwal->getById($id_jadwal);
        $top['title'] = "Detail Jadwal Rapat - Komunitas";
        $this->load->view('layouts/Top', $top);
        $this->load->view('layouts/Nav');
        $this->load->view('jadwal/VDetail', $data);
        $this->load->view('layouts/Bottom');
    }

    public function add()
    {
        if (isset($_POST['submit'])) {
            $cekKomunitas = $this->MKomunitas->cekWithId($this->input->post('komunitas'));
            $cekAdmin = $cekAdmin = $this->MAnggota->cekAdmin($this->session->userdata('id'), $cekKomunitas[0]->token);
            if ($cekAdmin) {
                $attr = array(
                    'judul_rapat' => $this->input->post('judul_rapat'),
                    'id_komunitas' => $this->input->post('komunitas'),
                    'token_komunitas' => $cekKomunitas[0]->token,
                    'nama_komunitas' => $cekKomunitas[0]->nama,
                    'isi' => $this->input->post('detail'),
                    'tanggal' => $this->input->post('tanggal'),
                    'waktu' => $this->input->post('waktu'),
                );
                if ($this->MJadwal->add($attr)) {
                    $this->setFlash('success', 'Success', 'Berhasil membuat jadwal rapat');
                    redirect('jadwal');
                } else {
                    $this->setFlash('warning', 'Error', 'Oops, terjadi error yang tidak diketahui');
                    redirect($_SERVER['HTTP_REFERER']);
                }
            } else {
                $this->setFlash('warning', 'Error', 'Oops, hanya admin yang dapat membuat jadwal rapat');
                redirect($_SERVER['HTTP_REFERER']);
            }
        } else {
            redirect($_SERVER['HTTP_REFERER']);
        }
    }

    public function update($id_komunitas, $id_jadwal)
    {
        // $data['jadwal'] = $this->MJadwal->getJadwalById($id_jadwal);
        $data['jadwal'] = $this->db->get_where('jadwal_rapat', ['id' => $id_jadwal])->row();
        $data['id_komunitas'] = $id_komunitas;
        $top['title'] = "Detail Jadwal Rapat - Komunitas";
        $this->load->view('layouts/Top', $top);
        $this->load->view('layouts/Nav');
        $this->load->view('jadwal/VUpdate', $data);
        $this->load->view('layouts/Bottom');
    }

    public function put($id_komunitas, $id_jadwal)
    {
        $cekKomunitas = $this->MKomunitas->cekWithId($id_komunitas);
        $cekAdmin = $cekAdmin = $this->MAnggota->cekAdmin($this->session->userdata('id'), $cekKomunitas[0]->token);
        if ($cekAdmin) {
            $data = [
                'judul_rapat' => $this->input->post('judul_rapat'),
                'isi' => $this->input->post('detail'),
                'tanggal' => $this->input->post('tanggal'),
                'waktu' => $this->input->post('waktu'),
            ];
            $update = $this->MJadwal->update($data, $id_jadwal);
            if ($update) {
                $this->setFlash('success', 'Sukses', 'Berhasil mengupdate jadwal');
                redirect('jadwal/detail/' . $id_jadwal);
            } else {
                $this->setFlash('warning', 'Error', 'Oops, some error occured');
                redirect($_SERVER['HTTP_REFERER']);
            }
        } else {
            $this->setFlash('warning', 'Error', 'Oops, hanya admin yang dapat megubah jadwal');
            redirect($_SERVER['HTTP_REFERER']);
        }
    }

    public function delete($id_komunitas, $id_jadwal)
    {
        $cekKomunitas = $this->MKomunitas->cekWithId($id_komunitas);
        $cekAdmin = $cekAdmin = $this->MAnggota->cekAdmin($this->session->userdata('id'), $cekKomunitas[0]->token);
        if ($cekAdmin) {
            $hapus = $this->MJadwal->delete($id_jadwal);
            if ($hapus) {
                $this->setFlash('success', 'Sukses', 'Berhasil menghapus jadwal');
                redirect('jadwal');
            } else {
                $this->setFlash('warning', 'Error', 'Oops, some error occured');
                redirect($_SERVER['HTTP_REFERER']);
            }
        } else {
            $this->setFlash('warning', 'Error', 'Oops, hanya admin yang dapat meghapus jadwal');
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
