<div class="main-content" id="panel">
    <?php $this->load->view('layouts/Navbar'); ?>
    <div class="header bg-danger pb-6">
        <div class="container-fluid">
            <div class="header-body">
                <div class="row align-items-center py-4">
                    <div class="col-lg-6 col-12">
                        <h2 class="text-white mb-0 mt-4">Hi Kak <?php echo $this->session->userdata('name'); ?> </h2>
                        <p class="text-white mb-2">Selamat datang di laman jadwal komunitas</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container-fluid mt--6">
        <div class="row">
            <div class="col">
                <div class="card">
                    <div class="card-header border-0">
                        <h4 class="mb-0">Agenda Kamu</h4>
                    </div>
                    <div class="table-responsive">
                        <table class="table align-items-center table-flush">
                            <thead class="thead-light">
                                <tr>
                                    <th class="text-center">Agenda</th>
                                    <th class="text-center">Komunitas</th>
                                    <th class="text-center">Tanggal</th>
                                    <th class="text-center">Waktu</th>
                                    <th class="text-center"></th>
                                </tr>
                            </thead>
                            <tbody class="list">
                                <?php if ($jadwal_rapat) { ?>
                                    <?php foreach ($jadwal_rapat as $jr) { ?>
                                        <tr>
                                            <td class="text-center">
                                                <a class="text-default" href="<?php echo base_url() ?>jadwal/detail/<?php echo $jr->id ?>">
                                                    <?php echo $jr->judul_rapat ?>
                                                </a>
                                            </td>
                                            <td class="text-center"><?php echo $jr->nama_komunitas ?></td>
                                            <td class="text-center"><?php echo $jr->tanggal ?></td>
                                            <td class="text-center"><?php echo $jr->waktu ?></td>
                                            <td>
                                                <?php if ($jr->is_admin): ?>
                                                    <a href="<?php echo base_url() ?>jadwal/update/<?php echo $jr->id_komunitas ?>/<?php echo $jr->id_jadwal_rapat ?>" class="badge badge-info">
                                                        <i class="ni ni-settings-gear-65"></i>
                                                    </a>
                                                    <a href="<?php echo base_url() ?>jadwal/delete/<?php echo $jr->id_komunitas ?>/<?php echo $jr->id_jadwal_rapat ?>" class="badge badge-danger">
                                                        <i class="ni ni-scissors"></i>
                                                    </a>
                                                <?php endif ?>
                                            </td>
                                        </tr>
                                    <?php } ?>
                                <?php } else { ?>
                                    <tr>
                                        <td class="text-center" colspan="5">No Data Found</td>
                                    </tr>
                                <?php } ?>
                            </tbody>
                        </table>
                    </div>
                    <div class="card-footer py-4">
                        <?php if ($cek_admin): ?>
                            <a href="<?php echo base_url() ?>jadwal/buat" class="btn btn-sm btn-danger">Buat Jadwal Rapat</a>
                        <?php endif ?>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>