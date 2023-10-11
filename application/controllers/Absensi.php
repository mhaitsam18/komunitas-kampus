<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Absensi extends CI_Controller
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
        // $data['jadwal_rapat'] = $jadwal;
        
        $this->db->select('*, jadwal_rapat.id AS id_jadwal_rapat');
        $this->db->where('anggota.id_user', $this->session->userdata('id'));
        $this->db->join('komunitas', 'komunitas.id = jadwal_rapat.id_komunitas');
        $this->db->join('anggota', 'anggota.id_komunitas = komunitas.id');
        $data['jadwal_rapat'] = $this->db->get('jadwal_rapat')->result();

        

        $top['title'] = "Absensi - Komunitas";
        $this->load->view('layouts/Top', $top);
        $this->load->view('layouts/Nav');
        $this->load->view('absensi/VJadwal', $data);
        $this->load->view('layouts/Bottom');
    }

    public function detail($token_komunitas, $id_jadwal)
    {
        $data = [
            'absensi' => $this->MAbsensi->getByJadwal($id_jadwal),
            'jadwal' => $this->MJadwal->getById($id_jadwal),
            'komunitas' => $this->MKomunitas->cekWithToken($token_komunitas)->row_array()
        ];

        $top['title'] = "Absen Rapat - Komunitas";
        $this->load->view('layouts/Top', $top);
        $this->load->view('layouts/Nav');
        $this->load->view('absensi/VDetail', $data);
        $this->load->view('layouts/Bottom');
    }

    public function create($id_jadwal)
    {
        $jadwal = $this->MJadwal->getById($id_jadwal);
        if ($jadwal) {
            $token_komunitas = $jadwal[0]->token_komunitas;
            $anggota = $this->MAnggota->getAnggota($token_komunitas);
            foreach ($anggota as $a) {
                $data = [
                    'id_rapat' => $jadwal[0]->id,
                    'judul_rapat' => $jadwal[0]->judul_rapat,
                    'tgl_rapat' => $jadwal[0]->tanggal,
                    'waktu_rapat' => $jadwal[0]->waktu,
                    'id_user' => $a->id_user,
                    'nama_user' => $a->nama_user,
                    'id_komunitas' => $jadwal[0]->id_komunitas,
                    'token_komunitas' => $token_komunitas,
                    'nama_komunitas' => $jadwal[0]->nama_komunitas
                ];
                $this->MAbsensi->add($data);
            }
            redirect($_SERVER['HTTP_REFERER']);
        } else {
            $this->setFlash('warning', 'Error', 'Oops, jadwal tidak ditemukan');
            redirect($_SERVER['HTTP_REFERER']);
        }
    }

    public function hadir($id_absen)
    {
        $this->MAbsensi->hadir($id_absen);
        redirect($_SERVER['HTTP_REFERER']);
    }

    public function absen($id_absen)
    {
        $this->MAbsensi->absen($id_absen);
        redirect($_SERVER['HTTP_REFERER']);
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
